#!/usr/bin/zsh

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/topbar.log
polybar top 2>&1 | tee -a /tmp/topbar.log & disown

echo "Bars launched..."
