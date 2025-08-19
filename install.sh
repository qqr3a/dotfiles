#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Arch-specific install script for copying dotfiles into ~/.config
# Assumes dotfiles are already cloned into ~/dotfiles
# Place your package list at ~/dotfiles/packages.txt
# Usage: ./install.sh [--dry-run]

PKG_LIST="packages.txt"

dry_run=0

log() { echo -e "[\e[32mINFO\e[0m] $*"; }
err() { echo -e "[\e[31mERROR\e[0m] $*" >&2; exit 1; }

copy_dotfiles() {
  log "Copying config files from ~/dotfiles to ~/.config..."
  mkdir -p "$HOME/.config"
  cp -rvf "$HOME/dotfiles"/* "$HOME/.config/"
}

install_packages() {
  log "Installing packages listed in $PKG_LIST using yay..."
  yay -Sy --noconfirm
  yay -S --noconfirm - < "$PKG_LIST"
}

install_misc() {
git clone https://github.com/arpn/wofi-bluetooth.git /tmp/wofi-bluetooth \
&& bash /tmp/wofi-bluetooth/wofi-bluetooth \
&& rm -rf /tmp/wofi-bluetooth

}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --dry-run) dry_run=1; shift;;
    *) err "Unknown argument: $1";;
  esac
done

if [[ $dry_run -eq 1 ]]; then
  log "Dry run mode enabled. No changes will be made."
  log "Would copy contents of ~/dotfiles into ~/.config"
  log "Would install yay if not present"
  log "Would install packages from: $PKG_LIST using yay"
else
  copy_dotfiles
fi

log "Setup complete."
