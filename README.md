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

On a new machine, one line does everything:

```sh
export GITHUB_USERNAME=your-username
export SOURCE_DIR=~/.dotfiles

sh -c "$(curl -fsLS get.chezmoi.io)" -- init -S "$SOURCE_DIR" --apply "$GITHUB_USERNAME"
```

`$SOURCE_DIR` is where the repo is cloned, and it has to match the `sourceDir` in `.chezmoi.toml.tmpl`. Without `-S`, chezmoi clones into `~/.local/share/chezmoi` and the two no longer agree.

chezmoi then:
1. Prompts for your git email and full name
2. Creates the XDG directory structure
3. Installs Homebrew, and the packages in the Brewfile
4. Installs the language runtimes in `.tool-versions` through asdf
5. Applies the macOS defaults
6. Symlinks every configuration file

Homebrew brings the Xcode command line tools with it, so there is nothing to install first. Two things still need you:

- Homebrew asks for your password
- Sign in to the App Store first, or the `mas` entries fail

## What's Installed

### Terminal & Shell
- **Terminal:** Ghostty with Catppuccin Frappe theme
- **Shell:** Zsh with Powerlevel10k prompt
- **Plugins:** vi-mode, syntax-highlighting, autosuggestions, fzf
- **Tools:** zoxide (smart cd), eza (better ls), bat, ripgrep

### Development Tools
- **Version Manager:** asdf (Ruby, Python, Rust, Node, Go, Postgres, Redis, SQLite)
- **Editors:** Neovim with lazy.nvim, and Vim with vim-plug. Both use the Dracula theme
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
2. Vim and Neovim plugins install themselves on first launch
3. Tmux plugins: Press `Alt+Space + I` to install
4. Machine-specific git settings are configured via chezmoi templates

## Managing Dotfiles with chezmoi

This repo runs in `mode = "symlink"`, so each target links back to its source file. Editing a managed file takes effect immediately — the target *is* the source. But a **new** source file has no symlink yet, so nothing reads it until you apply. Same for renames and deletes.

```bash
# Editing an existing file: no apply needed
$EDITOR dot_config/zsh/aliases.zsh

# A new file stays invisible until applied
$EDITOR dot_config/zsh/docker.zsh
chezmoi apply ~/.config/zsh/docker.zsh

# When a change seems to have no effect, check the link
ls -l ~/.config/zsh/
```

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

Add new packages to the Brewfile by hand, with a short comment saying what they are for.

Each section starts with a line saying what it excludes. One way to pick a section is to read from the top and take the first one that does not exclude the package. Sections run from the small basket to the large one, so the first match is usually the more specific one.

### Update asdf Plugins and Tools
```bash
asdfup
asdf install
```

## Custom Functions

Located in `dot_config/zsh/functions/`, loaded from `$ZDOTDIR/functions`:
- `brewup` - Update all Homebrew packages
- `brewdiff` - Compare Brewfile with installed packages
- `asdfup` - Update all asdf plugins
- `gitclean` - Remove merged git branches
- `mkcd` - Create directory and cd into it
