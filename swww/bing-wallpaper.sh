#!/usr/bin/env bash

# Fetch Bing daily wallpaper and set it with swww
# Bing rotates images daily — idx=0 is today, idx=1 is yesterday, etc.
# We pick a random one from the last 8 days for variety on each run.

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
mkdir -p "$WALLPAPER_DIR"

# Pick a random image from last 8 Bing daily images
IDX=$((RANDOM % 8))

# Fetch image URL from Bing API (UHD resolution)
JSON=$(curl -s "https://www.bing.com/HPImageArchive.aspx?format=js&idx=$IDX&n=1&mkt=en-US")
URL_PATH=$(echo "$JSON" | jq -r '.images[0].urlbase')

if [ -z "$URL_PATH" ] || [ "$URL_PATH" = "null" ]; then
    echo "Failed to fetch Bing wallpaper URL"
    exit 1
fi

FULL_URL="https://www.bing.com${URL_PATH}_UHD.jpg"
FILENAME=$(basename "$URL_PATH" | tr -cd 'a-zA-Z0-9_-').jpg
FILEPATH="$WALLPAPER_DIR/$FILENAME"

# Download if not already cached
if [ ! -f "$FILEPATH" ]; then
    curl -s -o "$FILEPATH" "$FULL_URL"
    if [ $? -ne 0 ] || [ ! -s "$FILEPATH" ]; then
        echo "Failed to download wallpaper"
        exit 1
    fi
fi

# Clean up old wallpapers (keep last 30)
ls -t "$WALLPAPER_DIR"/*.jpg 2>/dev/null | tail -n +31 | xargs -r rm

# Set wallpaper with swww (smooth transition)
export SWWW_TRANSITION=fade
export SWWW_TRANSITION_DURATION=2
export SWWW_TRANSITION_FPS=60

swww img "$FILEPATH" \
    --transition-type fade \
    --transition-duration 2 \
    --transition-fps 60

echo "Wallpaper set: $FILENAME"
