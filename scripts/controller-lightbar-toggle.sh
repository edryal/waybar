#!/bin/bash

STATE_FILE="$HOME/.cache/dualsense-lightbar-state"

# default state if file doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "on" >"$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

set_state() {
    echo "$1" >"$STATE_FILE"
}

case "$1" in
on)
    dualsensectl lightbar on
    set_state "on"
    dunstify -r 999 -u low "DualSense" "Lightbar ON"
    ;;

off)
    dualsensectl lightbar off
    set_state "off"
    dunstify -r 999 -u low "DualSense" "Lightbar OFF"
    ;;

toggle)
    if [ "$STATE" = "on" ]; then
        dualsensectl lightbar off
        set_state "off"
        dunstify -r 999 -u low "DualSense" "Lightbar OFF"
    else
        dualsensectl lightbar on
        set_state "on"
        dunstify -r 999 -u low "DualSense" "Lightbar ON"
    fi
    ;;

*)
    dunstify -r 999 -u low "DualSense" "Usage: on | off | toggle"
    ;;
esac
