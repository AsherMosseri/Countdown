#!/bin/sh
# Publish the launch link.
#
#   ./reveal.sh https://example.com
#
# The URL is passed in at run time and never stored anywhere in this repo, so
# nothing here discloses it until this script runs. Writing link.json is what
# makes the link appear; any tab already sitting on the finished countdown picks
# it up within ~15 seconds without a refresh.
set -e

if [ -z "$1" ]; then
    echo "usage: ./reveal.sh <url>" >&2
    exit 1
fi

case "$1" in
    https://*) ;;
    *) echo "refusing: url must start with https://" >&2; exit 1 ;;
esac

DIR=$(cd "$(dirname "$0")" && pwd)
printf '{"url": "%s"}\n' "$1" > "$DIR/link.json"

cd "$DIR"
git add link.json
git commit -q -m "Publish launch link"
git push -q origin main

echo "pushed. live in ~60s at https://ashermosseri.github.io/Countdown/"
