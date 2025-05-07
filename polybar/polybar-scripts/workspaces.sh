#!/bin/bash

# Define the maximum number of workspaces
MAX_WORKSPACES=10

# Fetch workspace data once and process it all at once
WORKSPACES=$(i3-msg -t get_workspaces | jq -c '.[]')

for i in $(seq 1 $MAX_WORKSPACES); do
    if echo "$WORKSPACES" | jq -e --argjson i "$i" '. | select(.name == ($i | tostring) and .focused)' >/dev/null; then
        # Highlight focused workspace
        echo -n " %{F#C5C8C6}$i%{F-}"
    elif echo "$WORKSPACES" | jq -e --argjson i "$i" '. | select(.name == ($i | tostring))' >/dev/null; then
        # Display active but unfocused workspace
        echo -n " %{T8}$i%{T-}"
    else
        # Display inactive (non-existent) workspace
        echo -n " %{F#707880}%{T8}$i%{T-}%{F-}"
    fi
done

