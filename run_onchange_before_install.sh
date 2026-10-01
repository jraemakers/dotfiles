#!/usr/bin/env bash
# Run by chezmoi before applying dotfiles. Re-runs whenever this file changes.
set -e

# Fresh VPSes often log in as root without sudo installed
SUDO=""
[ "$(id -u)" -ne 0 ] && SUDO="sudo"

# Install dependencies
$SUDO apt-get update
$SUDO apt-get install -y curl git zsh fzf

# Install Oh My Zsh if not present (KEEP_ZSHRC prevents it from overwriting .zshrc)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  KEEP_ZSHRC=yes RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Clone, or update if already present
clone_or_update() {
  if [ -d "$2" ]; then
    git -C "$2" pull --ff-only --quiet || true
  else
    git clone --depth=1 "$1" "$2"
  fi
}

# Install extra plugins
clone_or_update https://github.com/zsh-users/zsh-autosuggestions         "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting      "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_or_update https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# Install Powerlevel10k
clone_or_update https://github.com/romkatv/powerlevel10k "$ZSH_CUSTOM/themes/powerlevel10k"

# Install MesloLGS Nerd Font, only on desktops (fontconfig present); servers don't need it
if command -v fc-cache &> /dev/null; then
  FONT_DIR="$HOME/.local/share/fonts"
  mkdir -p "$FONT_DIR"
  for style in "Regular" "Bold" "Italic" "Bold%20Italic"; do
    file="MesloLGS NF ${style//%20/ }.ttf"
    [ -f "$FONT_DIR/$file" ] || curl -fsSL -o "$FONT_DIR/$file" \
      "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20${style}.ttf"
  done
  fc-cache -f "$FONT_DIR"
fi

# Make zsh the default shell
ZSH_PATH="$(command -v zsh)"
if [ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "$ZSH_PATH" ]; then
  $SUDO chsh -s "$ZSH_PATH" "$(id -un)"
fi
