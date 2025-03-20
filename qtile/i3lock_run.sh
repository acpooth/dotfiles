#!/bin/bash
# inspiration: https://github.com/leonmutschke/i3lock-config?tab=readme-ov-file

# Image name
IMG=/tmp/i3lock.png
BLUR="7x6"

# Screenshot
maim $IMG

# Apply blur to the screenshot
magick $IMG -blur $BLUR $IMG

# execute i3lock
i3lock -i $IMG

# Delette screenshot
rm $IMG

# PICTURE=/tmp/i3lock.png
# SCREENSHOT="scrot $PICTURE"

# BLUR="5x4"

# $SCREENSHOT
# convert $PICTURE -blur $BLUR $PICTURE
