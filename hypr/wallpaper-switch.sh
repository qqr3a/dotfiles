#!/usr/bin/env bash
set -euo pipefail

# 1. Your wallpapers directory
WALLPAPER_DIR="$HOME/.config/wallpapers"

# Ensure the directory exists
if [[ ! -d "$WALLPAPER_DIR" ]]; then
  echo "Error: $WALLPAPER_DIR not found" >&2
  exit 1
fi

# 2. Gather all .jpeg/.jpg/.png files (sorted for consistency)
mapfile -t WALLS < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' \) | sort)

if (( ${#WALLS[@]} == 0 )); then
  echo "Error: No images in $WALLPAPER_DIR" >&2
  exit 1
fi

# 3. Prepare display names (filenames only)
mapfile -t BASENAMES < <(printf "%s\n" "${WALLS[@]##*/}")

# 4. Use wofi to select a wallpaper by name
CHOICE_NAME=$(printf "%s\n" "${BASENAMES[@]}" | wofi --dmenu --prompt "Choose wallpaper:")

# If no choice (escape), exit
if [[ -z "$CHOICE_NAME" ]]; then
  echo "No selection made, exiting." >&2
  exit 1
fi

# 5. Match the chosen name to the full path
NEXT_WALL=""
for i in "${!BASENAMES[@]}"; do
  if [[ "${BASENAMES[i]}" == "$CHOICE_NAME" ]]; then
    NEXT_WALL="${WALLS[i]}"
    break
  fi
done

if [[ -z "$NEXT_WALL" ]]; then
  echo "Error: Selected wallpaper not found." >&2
  exit 1
fi

# 6. Apply the wallpaper with Pywal
wal -i "$NEXT_WALL"

# 7. (Re)load Hyprland to pick up new colors
hyprctl reload
