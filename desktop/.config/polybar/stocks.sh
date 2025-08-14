source ~/.config/polybar/stocks-keys.sh # should include api_key (for alphavantage), api_key_fh (for finnhub), and stocks (array, for your stocks)

state_file="/tmp/stock_index" # get index of stock in stocks from stocks-keys
price_file="/tmp/stock_prices" # price of each stock in TICKER:PRICE format
market_open="09:30" # doesn't need changing usually, time market opens
market_close="16:00" # same as market_open but close time
timezone="America/New_York" # your timezone in tz database format

current_day=$(TZ=$timezone date +%u)
current_time=$(TZ=$timezone date +%H:%M)

if [[ $current_day -gt 5 ]] || [[ "$current_time" < "$market_open" ]] || [[ "$current_time" > "$market_close" ]]; then # this doesn't check holidays, but whatever. exit if market is closed
    exit 0 
fi

[[ ! -f $state_file ]] && echo 0 > "$state_file" # if the current index file doesn't exist, just set it to 0 (the first stock in $stocks)
index=$(<"$state_file") 
symbol="${stocks[$index]}" # get curr. symbol
json=$(curl -s "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$api_key") # use alphavantage by default
price=$(echo "$json" | grep -oP '"05\. price": "\K[0-9.]+' | head -n1)
[[ -n "$price" ]] && price=$(printf "%.2f" "$price") # round to 2 decimals, i think alphavantage just includes $x.xx00 for shits and giggles?

if [[ "$price" == "0.00" || -z "$price" ]]; then
    json=$(curl -s "https://finnhub.io/api/v1/quote?symbol=$symbol&token=$api_key_fh") # fallback to finnhub if needed for more niche stocks
    price=$(echo "$json" | grep -oP '"c":\K[0-9.]+' | head -n1)
    [[ -n "$price" ]] && price=$(printf "%.2f" "$price") # round to 2 decimals
fi

declare -A last_prices
[[ -f $price_file ]] && while IFS=":" read -r s p; do last_prices[$s]=$p; done < "$price_file"

index=$(( (index + 1) % ${#stocks[@]} ))
echo $index > "$state_file"

last_price=${last_prices[$symbol]}
indicator="±0.00%" # default to 0 change

if [[ -n "$last_price" ]]; then
    change=$(echo "$price - $last_price" | bc -l)
    percent_change=$(echo "scale=4; (($price - $last_price) / $last_price) * 100" | bc -l)
    percent_change=$(printf "%.2f" "$percent_change")
    if (( $(echo "$change > 0" | bc -l) )); then
        indicator="%{F#00FF00}+$percent_change%%{F-}" # % change indicator (up)
    elif (( $(echo "$change < 0" | bc -l) )); then
        indicator="%{F#FF0000}$percent_change%%{F-}" # % change indicator (down)
    fi
fi

last_prices[$symbol]=$price # update prev prices for future referencing for last_price
for s in "${!last_prices[@]}"; do
    echo "$s:${last_prices[$s]}"
done > "$price_file"

if [[ -n "$price" ]]; then
    echo "%{F#957DDA}$symbol%{F-} \$$price $indicator" # change #957DDA to your main_col in polybar config if you wanna
fi
