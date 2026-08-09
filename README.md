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

## Behavior

Each countdown ticks once a second and swaps to a "🎉" message on its own when
it reaches zero; the other keeps running. The timer stops once both have passed.

## Deploying

GitHub Pages serves `main` at the repository root, so pushing to `main` deploys.
A build takes about a minute.
