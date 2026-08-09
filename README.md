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
