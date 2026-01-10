# Migrate Dotbot to Chezmoi Implementation Plan

**Goal:** Replace dotbot-based dotfiles setup with chezmoi for better maintainability, cross-platform support, and templating capabilities.

**Architecture:** 
Chezmoi provides several advantages over dotbot: native secret management, built-in templating, better cross-platform support, and command execution. The migration keeps the same directory structure where possible (all topic-based configs stay organized). We'll convert `install.conf.yaml` into chezmoi's `chezmoi.toml` config and use chezmoi templates for machine-specific settings (git.config.local, macOS defaults).

**Tech Stack:** chezmoi (v2+), shell scripts, YAML/TOML config

---

## Overview of Changes

**Before (Dotbot):**
- Shell installer script that delegates to dotbot submodule
- `install.conf.yaml` with link/create/clean directives
- Manual script execution for setup tasks (brew, asdf, tpm, macos)

**After (Chezmoi):**
- `chezmoi init` and `chezmoi apply` workflow
- `chezmoi.toml` config (replacing install.conf.yaml)
- Dotfiles moved to `dotfiles/` directory (chezmoi standard)
- Templates for dynamic content (git config, paths)
- One-command setup and updates
- Git config.local and machine-specific secrets handled via templates

---

## Task 1: Setup Chezmoi and Initialize Repo

**Files:**
- Modify: `.gitignore`
- Create: `chezmoi.toml`
- Create: `.chezmoiignore`
- Create: `.chezmoiroot`
- Delete: `dotbot/` (submodule), `install`, `install.conf.yaml`

**Step 1: Install chezmoi locally**

Run: `brew install chezmoi`

Verify: `chezmoi --version` should show v2.x.x

**Step 2: Create .gitignore entry for chezmoi state**

In `/Users/abookyun/.dotfiles/.gitignore`, add:
```
.chezmoi.yaml.tmpl
.chezmoi.toml.tmpl
```

**Step 3: Create chezmoi.toml**

Create `/Users/abookyun/.dotfiles/chezmoi.toml`:
```toml
# Chezmoi configuration
# This file defines how dotfiles are applied

# Source directory containing dotfiles
sourceDir = "."

# Use ~/.config/chezmoi/chezmoi.toml for user-specific overrides
configFile = "~/.config/chezmoi/chezmoi.toml"

# Encryption (optional, for secrets)
# encryption = "age"
# age.identity = "~/.config/chezmoi/key.txt"
# age.recipient = "~/.config/chezmoi/key.pub"
```

**Step 4: Create .chezmoiignore**

Create `/Users/abookyun/.dotfiles/.chezmoiignore`:
```
LICENSE
README.md
docs/
.git/
.gitmodules
.github/
.mypy_cache/
.ruff_cache/
.DS_Store
*.md
chezmoi.toml
install.conf.yaml
dotbot/
scripts/
exact_path/to/exclude
```

**Step 5: Create .chezmoiroot**

Create `/Users/abookyun/.dotfiles/.chezmoiroot`:
```
#
```
(Empty file signals this directory root is the chezmoi source)

**Step 6: Remove dotbot submodule**

Run: `git rm -f dotbot/`
Run: `git commit -m "remove dotbot submodule"`

**Step 7: Commit chezmoi setup files**

Run:
```bash
git add chezmoi.toml .chezmoiignore .chezmoiroot .gitignore
git commit -m "feat: initialize chezmoi configuration"
```

---

## Task 2: Reorganize Dotfiles into Chezmoi Structure

**Files:**
- Move all config files into `dotfiles/` directory following chezmoi structure
- Create template files for dynamic content

**Step 1: Create dotfiles directory structure**

Run:
```bash
mkdir -p ~/temp-chezmoi
cd ~/temp-chezmoi
```

This is temporary staging; we'll move files in steps.

**Step 2: Understand chezmoi path mapping**

Chezmoi uses these patterns:
- `dotfiles/exact_path/to/file` → `/path/to/file` (exact paths for files)
- `dotfiles/dot_config/` → `~/.config/` (dot_ prefix = dot)
- `dotfiles/private_dot_ssh/` → `~/.ssh/` (private_ = hidden from git tracking)

**Step 3: Create dotfiles directory and reorganize zsh files**

Run:
```bash
mkdir -p ~/.dotfiles/dotfiles/dot_config/zsh/functions
# Move zsh files
cp ~/.dotfiles/zsh/zshenv ~/.dotfiles/dotfiles/dot_zshenv
cp ~/.dotfiles/zsh/zshrc ~/.dotfiles/dotfiles/dot_config/zsh/dot_zshrc
cp ~/.dotfiles/zsh/aliases.zsh ~/.dotfiles/dotfiles/dot_config/zsh/aliases.zsh
cp ~/.dotfiles/zsh/general.zsh ~/.dotfiles/dotfiles/dot_config/zsh/general.zsh
cp ~/.dotfiles/zsh/completion.zsh ~/.dotfiles/dotfiles/dot_config/zsh/completion.zsh
cp ~/.dotfiles/zsh/p10k.zsh ~/.dotfiles/dotfiles/dot_config/zsh/dot_p10k.zsh
cp ~/.dotfiles/zsh/functions/* ~/.dotfiles/dotfiles/dot_config/zsh/functions/
```

**Step 4: Reorganize git, tmux, vim configs**

Run:
```bash
mkdir -p ~/.dotfiles/dotfiles/dot_config/{git,tmux,vim,nvim,ghostty,asdf,ruby,npm,wget,python,visidata}

# Git
cp ~/.dotfiles/git/config ~/.dotfiles/dotfiles/dot_config/git/config
cp ~/.dotfiles/git/ignore ~/.dotfiles/dotfiles/dot_config/git/ignore
# git/config.local will become a template in Task 3

# Tmux
cp ~/.dotfiles/tmux/tmux.conf ~/.dotfiles/dotfiles/dot_config/tmux/tmux.conf

# Vim/Nvim
cp ~/.dotfiles/vim/vimrc ~/.dotfiles/dotfiles/dot_config/vim/vimrc
cp ~/.dotfiles/vim/general.vimrc ~/.dotfiles/dotfiles/dot_config/vim/general.vimrc
cp ~/.dotfiles/vim/install.vimrc ~/.dotfiles/dotfiles/dot_config/vim/install.vimrc
cp ~/.dotfiles/vim/plugins.vimrc ~/.dotfiles/dotfiles/dot_config/vim/plugins.vimrc
cp ~/.dotfiles/vim/ale.vimrc ~/.dotfiles/dotfiles/dot_config/vim/ale.vimrc
cp -r ~/.dotfiles/nvim/* ~/.dotfiles/dotfiles/dot_config/nvim/

# Ghostty
cp ~/.dotfiles/ghostty/config ~/.dotfiles/dotfiles/dot_config/ghostty/config

# asdf
cp ~/.dotfiles/asdf/asdfrc ~/.dotfiles/dotfiles/dot_config/asdf/asdfrc
cp ~/.dotfiles/asdf/tool-versions ~/.dotfiles/dotfiles/dot_tool-versions

# Ruby
cp ~/.dotfiles/ruby/irbrc ~/.dotfiles/dotfiles/dot_config/ruby/irbrc
cp ~/.dotfiles/ruby/pryrc ~/.dotfiles/dotfiles/dot_config/ruby/pryrc

# Npm, wget, python
cp ~/.dotfiles/npm/config ~/.dotfiles/dotfiles/dot_config/npm/config
cp ~/.dotfiles/wget/wgetrc ~/.dotfiles/dotfiles/dot_config/wget/wgetrc
cp ~/.dotfiles/python/pythonrc ~/.dotfiles/dotfiles/dot_config/python/pythonrc

# Visidata - macOS special case
cp ~/.dotfiles/visidata/config.py ~/.dotfiles/dotfiles/dot_config/visidata/config.py
```

**Step 5: Verify all files copied**

Run: `find ~/.dotfiles/dotfiles -type f | wc -l` (should show count of files)

**Step 6: Commit reorganized files**

Run:
```bash
cd ~/.dotfiles
git add dotfiles/
git commit -m "feat: reorganize dotfiles into chezmoi structure"
```

---

## Task 3: Create Templates for Dynamic Content

**Files:**
- Create: `dotfiles/dot_config/git/config.tmpl`
- Create: `.chezmoi.toml.tmpl` (for machine-specific variables)
- Modify: `dotfiles/dot_zshenv.tmpl` (if XDG vars need templating)

**Step 1: Create machine identity template**

Create `/Users/abookyun/.dotfiles/.chezmoi.toml.tmpl`:
```toml
# Machine-specific chezmoi configuration
# Edit ~/.config/chezmoi/chezmoi.toml to override

sourceDir = "."

[data]
# Machine name for conditionals in templates
machine = "{{ .machine }}"
email = "{{ .email }}"
fullname = "{{ .fullname }}"
```

**Step 2: Create git config template**

Create `/Users/abookyun/.dotfiles/dotfiles/dot_config/git/config.tmpl`:
```
# Copy original config content, then add:

[include]
    path = ~/.config/git/config.local

# Template variables can be used here if needed
{{ if eq .machine "work" }}
[user]
    name = {{ .fullname }}
    email = {{ .email }}
{{ end }}
```

For now, keep it simple: include the local config without templating user identity (users will set in local).

**Step 3: Create git config.local prompt template**

Create `/Users/abookyun/.dotfiles/dotfiles/dot_config/git/config.local.tmpl`:
```
# Local git configuration (machine-specific, not tracked)
# Set your git user here or in ~/.config/chezmoi/chezmoi.toml

[user]
    name = {{ .fullname | default "Your Name" }}
    email = {{ .email | default "your.email@example.com" }}
```

**Step 4: Initialize chezmoi data on first run**

Users will run:
```bash
chezmoi init --data=false
# Then edit ~/.config/chezmoi/chezmoi.toml with machine-specific values
```

**Step 5: Test template parsing**

Run: `chezmoi execute-template '{{ .machine }}'` (should prompt for machine value on first run)

**Step 6: Commit templates**

Run:
```bash
cd ~/.dotfiles
git add dotfiles/dot_config/git/config.tmpl dotfiles/dot_config/git/config.local.tmpl .chezmoi.toml.tmpl
git commit -m "feat: add templates for machine-specific configuration"
```

---

## Task 4: Create Run Scripts (Chezmoi Replacements)

**Files:**
- Create: `dotfiles/run_onchange_*.sh` (chezmoi run_onchange scripts)
- Create: `dotfiles/run_*.sh` (chezmoi run scripts)
- Keep: existing `scripts/` for reference or move selectively

**Step 1: Create run_onchange_brew.sh for Homebrew**

Create `/Users/abookyun/.dotfiles/dotfiles/run_onchange_after_brew.sh.tmpl`:
```bash
#!/bin/bash
# Run after dotfiles applied, only if Brewfile changes
# {{ include "scripts/brew.sh" }}

# This will be executed by: chezmoi apply (detects Brewfile changes)

set -e

# Install homebrew if not exists
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Run brew bundle
cd ~/.dotfiles
brew bundle
```

**Step 2: Create run_onchange_asdf.sh**

Create `/Users/abookyun/.dotfiles/dotfiles/run_onchange_after_asdf.sh.tmpl`:
```bash
#!/bin/bash
# Run after dotfiles applied, only if tool-versions changes

set -e

# Source asdf if installed
if [ -d ~/.asdf ]; then
    . ~/.asdf/asdf.sh
    asdf plugin update --all || true
    asdf install
fi
```

**Step 3: Create run_once_macos.sh for macOS setup**

Create `/Users/abookyun/.dotfiles/dotfiles/run_once_after_macos.sh.tmpl`:
```bash
#!/bin/bash
# Run once after initial setup on macOS only
# {{ if eq .chezmoi.os "darwin" }}

set -e

# Include macOS defaults from existing script
{{ include "scripts/macos.sh" }}
```

**Step 4: Create run_once_tpm.sh for tmux plugin manager**

Create `/Users/abookyun/.dotfiles/dotfiles/run_once_after_tpm.sh.tmpl`:
```bash
#!/bin/bash
# Run once to setup tmux plugin manager

set -e

if [ ! -d ~/.local/share/tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
fi

# User runs: <prefix> + I to install plugins
echo "Tmux plugins installed. Press <prefix> + I in tmux to install plugins."
```

**Step 5: Test run scripts exist**

Run: `ls -la ~/.dotfiles/dotfiles/run_*.sh`

**Step 6: Commit run scripts**

Run:
```bash
cd ~/.dotfiles
chmod +x dotfiles/run_*.sh
git add dotfiles/run_*.sh
git commit -m "feat: add chezmoi run scripts for initialization tasks"
```

---

## Task 5: Create Installation and Usage Documentation

**Files:**
- Create: `CHEZMOI.md` (new setup instructions)
- Modify: `README.md` (update installation and update instructions)

**Step 1: Create CHEZMOI.md guide**

Create `/Users/abookyun/.dotfiles/CHEZMOI.md`:
```markdown
# Chezmoi Setup Guide

## What is Chezmoi?

Chezmoi is a dotfiles manager that:
- Manages dotfiles across multiple machines
- Supports templating for machine-specific configs
- Built-in encryption for secrets
- Fast and reliable

## First-Time Setup

### On a new machine:

1. Install chezmoi:
   ```bash
   brew install chezmoi
   ```

2. Initialize and apply dotfiles:
   ```bash
   chezmoi init --apply https://github.com/abookyun/dotfiles
   ```

3. During initialization, you'll be prompted for:
   - Machine name (e.g., "laptop", "work")
   - Email address
   - Full name

4. These values are stored in `~/.config/chezmoi/chezmoi.toml`

5. Review and configure machine-specific settings:
   ```bash
   vim ~/.config/chezmoi/chezmoi.toml
   ```

6. Reapply if you changed config:
   ```bash
   chezmoi apply
   ```

7. After applying:
   - Restart terminal: `exec zsh`
   - Install Tmux plugins: Press `<prefix> + I` in tmux
   - Vim plugins auto-install on first launch

## Daily Workflows

### Check what would change:
```bash
chezmoi diff
```

### Apply dotfiles (safe):
```bash
chezmoi apply
```

### Update dotfiles repo and reapply:
```bash
chezmoi update
```

### Edit a dotfile directly:
```bash
chezmoi edit ~/.config/zsh/.zshrc
# When you save, it asks to apply changes immediately
```

### For git config.local (machine-specific):
```bash
# Edit local git config
vim ~/.config/git/config.local

# Or use chezmoi to manage it
chezmoi edit ~/.config/git/config.local
```

## Configuration Files

- User config: `~/.config/chezmoi/chezmoi.toml`
- Dotfiles source: `~/.dotfiles/` (this repo)
- Templates: Files with `.tmpl` extension in dotfiles/

## Troubleshooting

### See what chezmoi will do:
```bash
chezmoi diff
```

### Dry-run apply:
```bash
chezmoi apply --dry-run
```

### View template variables:
```bash
chezmoi execute-template '{{ . | toJson }}'
```

### Forget a file (remove chezmoi tracking):
```bash
chezmoi forget ~/.config/some/file
```
```

**Step 2: Update README.md Installation section**

Edit `/Users/abookyun/.dotfiles/README.md`, replace the Installation section:

Old:
```
## Installation

**Warning**: You should not directly use this repo as your setting unless you fully reviewed the code.

```sh
git clone https://github.com/abookyun/dotfiles ~/.dotfiles
~/.dotfiles/scripts/bootstrap
```
```

New:
```
## Installation

**Warning**: You should not directly use this repo as your setting unless you fully reviewed the code.

### Prerequisites
- Homebrew (for macOS)
- Chezmoi v2+

### Quick Start
```sh
brew install chezmoi
chezmoi init --apply https://github.com/abookyun/dotfiles
```

You'll be prompted for machine-specific settings (name, email, etc.)

### For detailed setup instructions, see [CHEZMOI.md](CHEZMOI.md)
```

**Step 3: Update README.md Updating section**

Old:
```
## Updating

Update dotfiles:
```bash
cd ~/.dotfiles && git pull && ./install
```
```

New:
```
## Updating

Update dotfiles and reapply:
```bash
chezmoi update
```

Or manually:
```bash
cd ~/.dotfiles && git pull && chezmoi apply
```
```

**Step 4: Commit documentation**

Run:
```bash
cd ~/.dotfiles
git add CHEZMOI.md README.md
git commit -m "docs: add chezmoi setup guide and update installation instructions"
```

---

## Task 6: Verify Migration and Clean Up

**Files:**
- Delete: `install` script
- Delete: `install.conf.yaml`
- Delete: `dotbot/` (already done in Task 1)
- Keep: `scripts/` directory (referenced by run scripts via `include`)

**Step 1: Remove old dotbot files**

Run:
```bash
cd ~/.dotfiles
rm -f install install.conf.yaml
git add -A
git commit -m "feat: remove dotbot-specific files"
```

**Step 2: Test chezmoi apply locally**

Run:
```bash
# Dry-run first
chezmoi apply --dry-run

# If looks good, apply
chezmoi apply
```

Expected output: files being linked/created to home directory

**Step 3: Verify key dotfiles exist**

Run:
```bash
# Check important links
ls -la ~/.zshenv
ls -la ~/.config/zsh/.zshrc
ls -la ~/.config/git/config
ls -la ~/.config/tmux/tmux.conf
```

All should exist and show correct permissions.

**Step 4: Test git config template**

Run:
```bash
cat ~/.config/git/config.local
# Should contain [user] section with your git name/email
```

**Step 5: Test templated zsh environment**

Run:
```bash
echo $XDG_CONFIG_HOME
# Should be /Users/abookyun/.config or similar
```

**Step 6: Create git tag for migration**

Run:
```bash
cd ~/.dotfiles
git tag -a chezmoi-migration -m "migrate from dotbot to chezmoi"
git push origin chezmoi-migration
```

**Step 7: Final commit**

Run:
```bash
cd ~/.dotfiles
git log --oneline | head -10  # Verify clean history
```

Should show commits:
- remove dotbot-specific files
- add chezmoi run scripts
- add templates for machine-specific configuration
- reorganize dotfiles into chezmoi structure
- initialize chezmoi configuration

---

## Rollback Plan (if needed)

If migration fails, we have git tags to revert:
```bash
git checkout HEAD~N  # Go back N commits
# Or use the tag we created
```

The original `install.conf.yaml` and `dotbot/` are still in git history.

---

## Post-Migration

### Optional: Use chezmoi encryption for secrets

If you have sensitive data (API keys, SSH keys):
```bash
chezmoi re-encrypt  # requires age/GPG setup
```

### Share settings across machines

Edit `~/.config/chezmoi/chezmoi.toml` per machine, dotfiles source stays the same.

### Add new dotfiles

```bash
chezmoi add ~/.config/newapp/config
# Automatically moves it to dotfiles/ and links it
```

---
