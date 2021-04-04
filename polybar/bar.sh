#!/usr/bin/zsh

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/topbar.log
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar top 2>&1 | tee -a /tmp/topbar.log & disown
  done
else
    polybar top 2>&1 | tee -a /tmp/topbar.log & disown
fi

echo "Bars launched..."
