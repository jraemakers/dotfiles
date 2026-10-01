# dotfiles

My personal zsh configuration, managed with [chezmoi](https://www.chezmoi.io/) so a new machine or VPS can be set up with one command.

## What's included

- **dot_zshrc** → `~/.zshrc` — main zsh config with Oh My Zsh, Powerlevel10k, and plugins
- **dot_p10k.zsh** → `~/.p10k.zsh` — Powerlevel10k prompt configuration
- **run_onchange_before_install.sh** — installs zsh, git, fzf, Oh My Zsh, Powerlevel10k and plugins, and sets zsh as the default shell

## Install

On a new machine (Debian/Ubuntu, works as root or as a user with sudo):

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply jraemakers
```

This installs chezmoi to `~/.local/bin`, clones this repo, runs the install script and places the config files. Log out and back in to start using zsh.

Existing `~/.zshrc` / `~/.p10k.zsh` files are overwritten; chezmoi asks before doing so if they differ.

## Updating

```bash
chezmoi update        # pull latest changes from git and apply them
chezmoi edit ~/.zshrc # edit the source file, then `chezmoi apply`
chezmoi cd            # open a shell in the source repo to commit and push
```

## Nerd Font

Powerlevel10k needs a Nerd Font to display icons. The font matters on the computer you **connect from**, not on the VPS.

The install script installs [MesloLGS NF](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) automatically on desktop machines (it's skipped on servers without fontconfig). You still need to select **MesloLGS NF** as the font in your terminal emulator, e.g. in VS Code:

```json
"terminal.integrated.fontFamily": "MesloLGS NF"
```

## Machine-specific config

Anything that shouldn't be shared (secrets, machine-specific paths, env vars) goes in `~/.zshrc.local`, which is sourced if it exists and is not managed by this repo.

## License

[MIT](LICENSE)
