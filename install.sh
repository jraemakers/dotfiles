#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Install dependencies
sudo apt update && sudo apt install -y curl zsh

# Install Oh My Zsh if not present (KEEP_ZSHRC prevents it from overwriting .zshrc)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_if_missing() {
  [ -d "$2" ] || git clone --depth=1 "$1" "$2"
}

# Install extra plugins
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions         "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting      "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# Install Powerlevel10k
clone_if_missing https://github.com/romkatv/powerlevel10k "$ZSH_CUSTOM/themes/powerlevel10k"

# Install fzf (required for zsh-interactive-cd)
if ! command -v fzf &> /dev/null; then
  sudo apt install -y fzf
fi

# Remove existing config files to avoid conflicts
rm -f "$HOME/.zshrc"
rm -f "$HOME/.p10k.zsh"

# Symlink configs
ln -sf "$DOTFILES/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/p10k.zsh" "$HOME/.p10k.zsh"

# Create local override file if it doesn't exist
touch "$HOME/.zshrc.local"

echo "Done! Restart your terminal."
