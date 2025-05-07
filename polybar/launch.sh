#!/usr/bin/env bash

# Terminate already running Polybar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        
        MONITOR=$m polybar --reload workspaces &
        MONITOR=$m polybar --reload window &
        MONITOR=$m polybar --reload extra &
        MONITOR=$m polybar --reload center &
        MONITOR=$m polybar --reload control &
        MONITOR=$m polybar --reload info &

        #MONITOR=$m polybar --reload example &

    done
else
    polybar --reload example &
fi
