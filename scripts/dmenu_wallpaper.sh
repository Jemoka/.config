#!/bin/zsh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

WALLPAPERS=`ls ${HOME}/Documents/Resources/wallpapers/wallpaper*`

cr='
'
for item in ${WALLPAPERS//\\n/$cr}
do
   echo "Item: $item"
done

CHOSEN=$(echo "${WALLPAPERS}" | dmenu -p "Wallpaper" -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn 'Hack Nerd Font:pixelsize=14:antialias=true:autohint=true' -i -g 0 -l 1000)

wal -i $CHOSEN

