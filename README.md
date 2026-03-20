# dotfiles

My personal zsh configuration, portable across machines.

## What's included

- **zshrc** — main zsh config with Oh My Zsh, Powerlevel10k, and plugins
- **p10k.zsh** — Powerlevel10k prompt configuration
- **install.sh** — bootstrap script for new machines

## Install

**1. Install prerequisites**
```bash
sudo apt update && sudo apt install -y git
```

**2. Clone and run**
```bash
git clone https://github.com/jraemakers/dotfiles.git ~/dotfiles
cd ~/dotfiles && bash install.sh
```

This will install curl, zsh, Oh My Zsh, Powerlevel10k, plugins, fzf, and symlink the config files.

**3. Set zsh as default shell**
```bash
chsh -s $(which zsh)
```

**4. Install a Nerd Font**

Powerlevel10k requires a Nerd Font to display correctly. Download and install [MesloLGS NF](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) and set it in your terminal emulator.

Then log out and back in.

## Machine-specific config

Anything that shouldn't be shared (secrets, machine-specific paths, env vars) goes in `~/.zshrc.local`. This file is created automatically by the install script but is not committed to git.
