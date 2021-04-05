#!/bin/zsh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

TIMERS=`python -m toggl -s ls -f description | sort -r | uniq`

CHOSEN=$(echo "${TIMERS}\n\$tstart\n\$tstop" | dmenu -p "Timers" -nb "$color0" -nf "$color15" -sb "$color1" -sf "$color15" -fn 'Hack Nerd Font:pixelsize=14:antialias=true:autohint=true' -i)

[[ $TIMERS =~ (^|[[:space:]])$CHOSEN($|[[:space:]]) ]] && true || false

if [ $? -eq 0 ]; then
    case $CHOSEN in
        "\$tstop")
            python -m toggl stop
            ;;
        "\$tstart")
            python -m toggl start
            ;;
        *)
            python -m toggl continue $CHOSEN
            ;;
    esac
else
    python -m toggl start $CHOSEN
fi


