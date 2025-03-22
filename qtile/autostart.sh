#!/bin/sh

################################
# Autostart programs for qtile #
################################

# kupfer &
dropbox start &
setxkbmap -layout us -variant altgr-intl -option ctrl:nocaps &
# xcompmgr -cf -D 5 &
picom &
flameshot &
syncthing &
