#!/usr/bin/env zsh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

PATH="/opt/resolve/bin/:${PATH}" dmenu_run -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn 'Hack Nerd Font:pixelsize=17:antialias=true:autohint=true'

