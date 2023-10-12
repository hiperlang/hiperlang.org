#!/bin/bash

CNAME="src/CNAME"
PAGES="src/{*.html,ru/**/*.html}"
FAVICON="src/assets/icons/favicon.ico"
ICONS="src/assets/icons/*{.svg,.png}"
FONTS="src/assets/fonts/*.woff2"
MANIFEST="src/assets/*.webmanifest"
STYLES="src/assets/styles/styles.css"
STYLES_OUT="public/assets/styles.css"
UTILS_OUT="src/assets/styles/utilities.css"
PM="bunx"

# Production build
if [ "$1" = "--release" ]; then
  bunx cpx "$CNAME" public
  bunx cpx "$PAGES" public
  bunx cpx "$FAVICON" public
  bunx cpx "$ICONS" public/assets
  bunx cpx "$FONTS" public/assets
  bunx cpx "$MANIFEST" public/assets
  bunx unocss "$PAGES" --out-file "$UTILS_OUT" --preflights false
  bunx postcss "$STYLES" --output "$STYLES_OUT" --use postcss-import --use autoprefixer --autoprefixer '> 1%, last 5 versions' --use cssnano --no-map
  exit 0
fi

# Development build
$PM conc --kill-others \
  "$PM cpx \"$CNAME\" public --watch" \
  "$PM cpx \"$PAGES\" public --watch" \
  "$PM cpx \"$FAVICON\" public --watch" \
  "$PM cpx \"$ICONS\" public/assets --watch" \
  "$PM cpx \"$FONTS\" public/assets --watch" \
  "$PM cpx \"$MANIFEST\" public/assets --watch" \
  "$PM unocss \"$PAGES\" --out-file \"$UTILS_OUT\" --preflights false --watch" \
  "$PM postcss \"$STYLES\" --output \"$STYLES_OUT\" --use postcss-import --use autoprefixer --autoprefixer '> 1%, last 5 versions' --watch" \
  "$PM web-dev-server --root-dir=public --watch"
