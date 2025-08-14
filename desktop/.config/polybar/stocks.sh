source ~/.config/polybar/stocks-keys.sh

state_file="/tmp/stock_index"
price_file="/tmp/stock_prices"
market_open="09:30"
market_close="16:00"
timezone="America/New_York"

current_day=$(TZ=$timezone date +%u)
current_time=$(TZ=$timezone date +%H:%M)

if [[ $current_day -gt 5 ]] || [[ "$current_time" < "$market_open" ]] || [[ "$current_time" > "$market_close" ]]; then
    exit 0
fi

[[ ! -f $state_file ]] && echo 0 > "$state_file"
index=$(<"$state_file")
symbol="${stocks[$index]}"
json=$(curl -s "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$api_key")
price=$(echo "$json" | grep -oP '"05\. price": "\K[0-9.]+' | head -n1)
[[ -n "$price" ]] && price=$(printf "%.2f" "$price")

if [[ "$price" == "0.00" || -z "$price" ]]; then
    json=$(curl -s "https://finnhub.io/api/v1/quote?symbol=$symbol&token=$api_key_fh")
    price=$(echo "$json" | grep -oP '"c":\K[0-9.]+' | head -n1)
    [[ -n "$price" ]] && price=$(printf "%.2f" "$price")
fi

declare -A last_prices
[[ -f $price_file ]] && while IFS=":" read -r s p; do last_prices[$s]=$p; done < "$price_file"

index=$(( (index + 1) % ${#stocks[@]} ))
echo $index > "$state_file"

last_price=${last_prices[$symbol]}
indicator="±0.00%"

if [[ -n "$last_price" ]]; then
    change=$(echo "$price - $last_price" | bc -l)
    percent_change=$(echo "scale=4; (($price - $last_price) / $last_price) * 100" | bc -l)
    percent_change=$(printf "%.2f" "$percent_change")
    if (( $(echo "$change > 0" | bc -l) )); then
        indicator="%{F#00FF00}+$percent_change%%{F-}"
    elif (( $(echo "$change < 0" | bc -l) )); then
        indicator="%{F#FF0000}$percent_change%%{F-}"
    fi
fi

last_prices[$symbol]=$price
for s in "${!last_prices[@]}"; do
    echo "$s:${last_prices[$s]}"
done > "$price_file"

if [[ -n "$price" ]]; then
    echo "%{F#957DDA}$symbol%{F-} \$$price $indicator"
else
    echo "$symbol: N/A"
fi
