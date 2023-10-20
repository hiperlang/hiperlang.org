#!/bin/bash

PM="bunx"

IN="src"

CNAME="$IN/CNAME"
PAGES="$IN/pages/{*.html,ru/**/*.html}"
PAGE_RU_INDEX="$IN/pages/ru/index"
TEMPL_IGNORE="*.t.html"
ICONS="$IN/icons/export/*{.svg,.png,.ico}"
FONTS="$IN/fonts/*.woff2"
MANIFEST="$IN/*.webmanifest"
STYLES="$IN/styles/styles.css"
UTILS_OUT="$IN/styles/utilities.css"
TEMPL_ENGINE="$IN/pages/build-page.py"
TEMPLS="$IN/pages"

OUT="docs"

CNAME_OUT="$OUT"
PAGES_OUT="$OUT"
ICONS_OUT="$OUT"
FONTS_OUT="$OUT"
MANIFEST_OUT="$OUT"
STYLES_OUT="$OUT/styles.css"

# bunx nodemon --exec "./src/pages/build-page.py src/pages/ru/index.t.html --output src/pages/ru/index.html" --watch src/pages/shared -e .t.html

# Production build
if [ "$1" = "--release" ]; then
  bunx cpx "$CNAME" "$CNAME_OUT"
  bunx cpx "$PAGES" "$PAGES_OUT" --ignore "$TEMPL_IGNORE"
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
  "$PM cpx \"$PAGES\" $PAGES_OUT --ignore $TEMPL_IGNORE --watch" \
  "$PM cpx \"$ICONS\" $ICONS_OUT --watch" \
  "$PM cpx \"$FONTS\" $FONTS_OUT --watch" \
  "$PM cpx \"$MANIFEST\" $MANIFEST_OUT --watch" \
  "$PM unocss \"$PAGES\" --out-file \"$UTILS_OUT\" --preflights false --watch" \
  "$PM postcss \"$STYLES\" --output \"$STYLES_OUT\" --use postcss-import --use autoprefixer --autoprefixer '> 1%, last 5 versions' --watch" \
  "$PM web-dev-server --root-dir=$OUT --watch"

# "$PM nodemon --exec \"./$TEMPL_ENGINE $PAGE_RU_INDEX.htm --output $PAGE_RU_INDEX.html\" --watch $TEMPLS -e htm" \
