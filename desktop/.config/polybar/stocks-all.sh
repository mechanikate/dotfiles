
source ~/.config/polybar/stocks-keys.sh
output=()
for stock in "${stocks[@]}"
do
	output+=("$(~/.config/polybar/stocks-indiv.sh $stock)")
done
separator=" %%{F#707880}|%%{F-} "
sepbland=" %{F#707880}|%{F-} "
joined="$( printf "${separator}%s" "${output[@]}" )"
joined="${joined:${#sepbland}}" # remove leading separator
echo "${joined}"
