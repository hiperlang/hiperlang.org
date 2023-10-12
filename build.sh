#!/bin/bash

OUT="docs"
CNAME="src/CNAME"
PAGES="src/{*.html,ru/**/*.html}"
FAVICON="src/assets/icons/favicon.ico"
ICONS="src/assets/icons/*{.svg,.png}"
FONTS="src/assets/fonts/*.woff2"
MANIFEST="src/assets/*.webmanifest"
STYLES="src/assets/styles/styles.css"
STYLES_OUT="$OUT/assets/styles.css"
UTILS_OUT="src/assets/styles/utilities.css"
PM="bunx"

# Production build
if [ "$1" = "--release" ]; then
  bunx cpx "$CNAME" "$OUT"
  bunx cpx "$PAGES" "$OUT"
  bunx cpx "$FAVICON" "$OUT"
  bunx cpx "$ICONS" "$OUT"/assets
  bunx cpx "$FONTS" "$OUT"/assets
  bunx cpx "$MANIFEST" "$OUT"/assets
  bunx unocss "$PAGES" --out-file "$UTILS_OUT" --preflights false
  bunx postcss "$STYLES" --output "$STYLES_OUT" --use postcss-import --use autoprefixer --autoprefixer '> 1%, last 5 versions' --use cssnano --no-map
  exit 0
fi

# Development build
$PM conc --kill-others \
  "$PM cpx \"$CNAME\" $OUT --watch" \
  "$PM cpx \"$PAGES\" $OUT --watch" \
  "$PM cpx \"$FAVICON\" $OUT --watch" \
  "$PM cpx \"$ICONS\" $OUT/assets --watch" \
  "$PM cpx \"$FONTS\" $OUT/assets --watch" \
  "$PM cpx \"$MANIFEST\" $OUT/assets --watch" \
  "$PM unocss \"$PAGES\" --out-file \"$UTILS_OUT\" --preflights false --watch" \
  "$PM postcss \"$STYLES\" --output \"$STYLES_OUT\" --use postcss-import --use autoprefixer --autoprefixer '> 1%, last 5 versions' --watch" \
  "$PM web-dev-server --root-dir=$OUT --watch"
