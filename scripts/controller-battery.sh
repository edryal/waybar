#!/bin/bash
out=$(dualsensectl battery 2>/dev/null)
pct=$(awk '{print $1}' <<<"$out")
state=$(awk '{print $2}' <<<"$out")

# no controller / non-numeric percent
if ! [[ "$pct" =~ ^[0-9]+$ ]]; then
    printf '{"text":"","tooltip":"No controller connected"}\n'
    exit 0
fi

if [[ "$state" == "charging" ]]; then
    icon="󰂄"
elif ((pct <= 10)); then
    icon="󰁺"
elif ((pct <= 20)); then
    icon="󰁻"
elif ((pct <= 30)); then
    icon="󰁼"
elif ((pct <= 40)); then
    icon="󰁽"
elif ((pct <= 50)); then
    icon="󰁾"
elif ((pct <= 60)); then
    icon="󰁿"
elif ((pct <= 70)); then
    icon="󰂀"
elif ((pct <= 80)); then
    icon="󰂁"
elif ((pct <= 90)); then
    icon="󰂂"
else
    icon="󰁹"
fi

STATE_FILE="$HOME/.cache/dualsense-lightbar-state"
[[ -f "$STATE_FILE" ]] && lightbar=$(<"$STATE_FILE") || lightbar="unknown"

printf '{"text":" %s %s%% ","tooltip":"Battery: %s%%\\nState: %s\\nLightbar: %s"}\n' \
    "$icon" "$pct" "$pct" "$state" "${lightbar^^}"
