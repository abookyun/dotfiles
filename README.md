# dotfiles and beyond

I'd been using oh-my-zsh and square/maximum-awesome for years, big shout out to them and open-source community, I could fully focus on my projects. Time flies, without paying enough attention to my home folder, it inevitably turns into a mess. It's time to clean it up.

Inspired by @holman/dotfiles, and [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html#introduction), here are my goals:

1. One .dotfiles repo rules all settings.
2. All settings could easily apply to another machine.
3. Respect XDG Base Directory Specification.
4. Everything's built around topic.
5. By doing things above, learning and extending my knowledge.

## Installation

**Warning**: You should not directly use this repo as your setting unless you fully reviewed the code.

```sh
# Clone the repository
git clone https://github.com/abookyun/dotfiles ~/.dotfiles

# Initialize chezmoi and apply dotfiles
chezmoi init --source ~/.dotfiles
chezmoi apply -v
```

On first run, chezmoi will:
1. Prompt for your git email and full name
2. Create XDG directory structure
3. Install Homebrew packages automatically
4. Symlink all configuration files

## What's Installed

### Terminal & Shell
- **Terminal:** Ghostty with Catppuccin Frappe theme
- **Shell:** Zsh with Powerlevel10k prompt
- **Plugins:** vi-mode, syntax-highlighting, autosuggestions, fzf
- **Tools:** zoxide (smart cd), eza (better ls), bat, ripgrep

### Development Tools
- **Version Manager:** asdf (Ruby, Python, Rust, Node, Postgres, Redis, SQLite)
- **Editor:** Vim with 26 plugins (Dracula theme, ALE linter, fugitive, fzf.vim)
- **Multiplexer:** Tmux with Catppuccin theme
- **Git:** Custom aliases and configuration

### Key Features
- XDG Base Directory compliant - clean home directory
- Managed with chezmoi for flexible dotfiles deployment
- Automated Homebrew package management
- Template-based configuration for machine-specific settings

## Post-Installation

After applying dotfiles:
1. Restart terminal or run `exec zsh`
2. Vim plugins auto-install on first launch
3. Tmux plugins: Press `Alt+Space + I` to install
4. Machine-specific git settings are configured via chezmoi templates

## Managing Dotfiles with chezmoi

### Basic Operations

```bash
# Check what changes chezmoi would make
chezmoi diff

# Apply changes from source directory
chezmoi apply -v

# Edit a file managed by chezmoi (opens in $EDITOR)
chezmoi edit ~/.zshenv

# Add a new file to be managed
chezmoi add ~/.config/newapp/config.yml

# Update dotfiles from repository
cd ~/.dotfiles
git pull
chezmoi apply -v

# See what files chezmoi is managing
chezmoi managed

# Verify the state of managed files
chezmoi verify
```

### Working with Templates

The following files use chezmoi templates for machine-specific configuration:
- `.chezmoi.toml.tmpl` - Main configuration with git email/name prompts
- `run_once_before_01-create-xdg-directories.sh.tmpl` - XDG directory setup
- `run_once_after_02-install-brew-packages.sh.tmpl` - Homebrew package installation

### Common Workflows

```bash
# Add a new config file and edit it
chezmoi add ~/.config/app/config.yml
chezmoi edit ~/.config/app/config.yml

# Make changes and commit to git
cd ~/.dotfiles
git add .
git commit -m "Update app config"
git push

# Apply on another machine
cd ~/.dotfiles
git pull
chezmoi apply -v
```

## Updating

### Update Homebrew Packages
```bash
brewup
```

### Sync Brewfile with Installed Packages

When you install new packages, keep your Brewfile in sync:

```bash
# Compare Brewfile with currently installed packages
brewdiff

# The output shows:
# - Packages installed but not in Brewfile (add these to your Brewfile)
# - Packages in Brewfile but not installed (either install or remove from Brewfile)
```

Manually add new packages to your Brewfile in the appropriate section with comments to maintain organization.

### Update asdf Plugins and Tools
```bash
asdfup
asdf install
```

## Custom Functions

Located in `functions/` directory:
- `brewup` - Update all Homebrew packages
- `brewdiff` - Compare Brewfile with installed packages
- `asdfup` - Update all asdf plugins
- `gitclean` - Remove merged git branches
- `mkcd` - Create directory and cd into it
