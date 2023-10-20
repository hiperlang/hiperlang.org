#!/bin/bash
if [ -z "$1" ]; then
  echo "Please, provide an icon (eg. icon.svg)"
  exit 1
fi

# Clean image conversions
if [ "$1" == "--clean" ]; then
  rm -f favicon.ico hiper-512.png hiper-192.png apple-touch-icon.png
  exit 0
fi

# Perform image conversions
inkscape "$1" -w 32 -h 32 -o tmp.png
oxipng -o 4 tmp.png # compress
convert tmp.png favicon.ico
rm tmp.png
inkscape "$1" -w 512 -h 512 -o hiper-512.png
inkscape "$1" -w 192 -h 192 -o hiper-192.png
inkscape "$1" -w 180 -h 180 -o apple-touch-icon.png
oxipng -o 4 hiper-512.png hiper-192.png apple-touch-icon.png # compress
npx svgo --multipass "$1"                                    # compress
