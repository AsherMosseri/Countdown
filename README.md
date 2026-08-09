# Countdown

A single-page countdown to two launches, live at
**https://ashermosseri.github.io/Countdown/**

Everything is in `index.html` — no build step, no dependencies. Open the file
directly in a browser to preview changes.

## Changing a date

Edit the `launches` array near the bottom of `index.html`. Each date is written
in exactly one place; the human-readable line under each heading is derived from
the target, so the two can't drift apart.

```js
const launches = [
    { el: document.getElementById('site'), target: new Date("2026-08-10T19:00:00-04:00").getTime() },
    { el: document.getElementById('app'),  target: new Date("2026-08-25T16:00:00-04:00").getTime() }
];
```

The `-04:00` is Eastern Daylight Time. Pinning the offset means everyone sees
the same time remaining regardless of their own timezone. **Dates on or after
Nov 1 2026 fall in EST and must be written `-05:00`** — if you get it wrong the
displayed label will visibly disagree with what you intended, which is the
cheapest way to catch it.

## Revealing the launch link

The launch URL is intentionally **not** in this repository. GitHub Pages serves
these files publicly, so anything committed here is public — encoding or hiding
it in the page would be obfuscation, not secrecy.

Instead the page polls for `link.json` once a countdown reaches zero. That file
is absent (and the request 404s) until launch time, when publishing it makes the
link appear — including in tabs that are already open, with no refresh:

```sh
./reveal.sh https://example.com
```

That writes `link.json`, commits, and pushes; Pages redeploys in about a minute.
The URL is passed as an argument and never stored in the script.

Note that this controls *when the link is handed out*, not whether the
destination is reachable. A site that is already serving can be found by anyone
who tries the domain, regardless of what this page shows.

## Link preview image

`og-image.png` is what Messages/Slack show when the link is shared. It is a
screenshot of `og/card.html`, which derives its dates the same way the page
does. Preview fetchers don't run JavaScript, so the dates have to be baked into
the image rather than read from the page.

After changing a launch date, update the matching `data-target` in
`og/card.html` and regenerate:

```sh
./og/make-og.sh     # requires Google Chrome; writes og-image.png
```

Apple and Slack cache previews per URL, so a refreshed image may not appear for
an already-shared link. Sharing it with a throwaway query string
(`.../Countdown/?v=2`) forces a fresh fetch.

## Behavior

Each countdown ticks once a second and swaps to a "🎉" message on its own when
it reaches zero; the other keeps running. The timer stops once both have passed.

## Deploying

GitHub Pages serves `main` at the repository root, so pushing to `main` deploys.
A build takes about a minute.
