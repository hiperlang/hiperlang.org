#!/bin/bash

IN="src"
CNAME="$IN/CNAME"
PAGES="$IN/{*.html,ru/**/*.html}"
FAVICON="$IN/includes/icons/favicon.ico"
ICONS="$IN/includes/icons/*{.svg,.png}"
FONTS="$IN/includes/fonts/*.woff2"
MANIFEST="$IN/includes/*.webmanifest"
STYLES="$IN/includes/styles/styles.css"
UTILS_OUT="$IN/includes/styles/utilities.css"

OUT="docs"
CNAME_OUT="$OUT"
PAGES_OUT="$OUT"
FAVICON_OUT="$OUT"
ICONS_OUT="$OUT/assets"
FONTS_OUT="$OUT/assets"
MANIFEST_OUT="$OUT/assets"
STYLES_OUT="$OUT/assets/styles.css"
PM="bunx"

# Production build
if [ "$1" = "--release" ]; then
  bunx cpx "$CNAME" "$CNAME_OUT"
  bunx cpx "$PAGES" "$PAGES_OUT"
  bunx cpx "$FAVICON" "$FAVICON_OUT"
  bunx cpx "$ICONS" "$ICONS_OUT"
  bunx cpx "$FONTS" "$FONTS_OUT"
  bunx cpx "$MANIFEST" "$MANIFEST_OUT"
  bunx unocss "$PAGES" --out-file "$UTILS_OUT" --preflights false
  bunx postcss "$STYLES" --output "$STYLES_OUT" --use postcss-import --use autoprefixer --autoprefixer '> 1%, last 5 versions' --use cssnano --no-map
  exit 0
fi

# Development build
$PM conc --kill-others \
  "$PM cpx \"$CNAME\" $CNAME_OUT --watch" \
  "$PM cpx \"$PAGES\" $PAGES_OUT --watch" \
  "$PM cpx \"$FAVICON\" $FAVICON_OUT --watch" \
  "$PM cpx \"$ICONS\" $ICONS_OUT --watch" \
  "$PM cpx \"$FONTS\" $FONTS_OUT --watch" \
  "$PM cpx \"$MANIFEST\" $MANIFEST_OUT --watch" \
  "$PM unocss \"$PAGES\" --out-file \"$UTILS_OUT\" --preflights false --watch" \
  "$PM postcss \"$STYLES\" --output \"$STYLES_OUT\" --use postcss-import --use autoprefixer --autoprefixer '> 1%, last 5 versions' --watch" \
  "$PM web-dev-server --root-dir=$OUT --watch"
