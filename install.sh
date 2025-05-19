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

install_yay() {
  if ! command -v yay &>/dev/null; then
    log "Installing yay AUR helper..."
    sudo pacman -Sy --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
    rm -rf /tmp/yay
  else
    log "yay is already installed."
  fi
}

install_packages() {
  log "Installing packages listed in $PKG_LIST using yay..."
  yay -Sy --noconfirm
  yay -S --noconfirm - < "$PKG_LIST"
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
  install_yay
  install_packages
fi

log "Setup complete."
