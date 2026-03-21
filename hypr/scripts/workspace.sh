#!/usr/bin/env bash
# Maps Super+N to monitor-specific workspaces
# Left (DP-5):     11-20
# Center (HDMI-A-2): 1-10
# Right (DP-6):    21-30

NUM=$1
ACTION=${2:-focus}  # "focus" or "move"

# Get the monitor the cursor is on
MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')

case "$MONITOR" in
    DP-5)     WS=$((NUM + 10)) ;;
    DP-6)     WS=$((NUM + 20)) ;;
    *)        WS=$NUM ;;
esac

if [ "$ACTION" = "move" ]; then
    hyprctl dispatch movetoworkspace "$WS"
else
    hyprctl dispatch workspace "$WS"
fi
