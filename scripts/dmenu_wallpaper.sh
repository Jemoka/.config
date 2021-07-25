#!/bin/zsh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"


WALLPATH="${HOME}/Resources"
SPLIT_WALLPAPERS=""

for line in "$WALLPATH"/wallpaper*
do
    SPLIT_WALLPAPERS="$(basename $line)\n$SPLIT_WALLPAPERS"; 
done

SPLIT_WALLPAPERS=$(echo "${SPLIT_WALLPAPERS}"|head -c -1)

CHOSEN=$(echo "${SPLIT_WALLPAPERS}" | dmenu -p "Wallpaper" -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn 'Hack Nerd Font:pixelsize=17:antialias=true:autohint=true' -i -g 0 -l 1000)

wal -i "$WALLPATH/$CHOSEN"

