#!/bin/sh
# Regenerate the link-preview image from og/card.html.
# Run this after changing a launch date, then commit the updated PNG.
set -e

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
DIR=$(cd "$(dirname "$0")" && pwd)

"$CHROME" \
    --headless \
    --disable-gpu \
    --hide-scrollbars \
    --force-device-scale-factor=1 \
    --window-size=1200,630 \
    --screenshot="$DIR/../og-image.png" \
    "file://$DIR/card.html" 2>/dev/null

echo "wrote og-image.png"
