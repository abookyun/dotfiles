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
git clone https://github.com/abookyun/dotfiles ~/.dotfiles
~/.dotfiles/scripts/bootstrap
```

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
- Declarative setup with Dotbot
- Automated Homebrew package management

## Post-Installation

After running `./install`:
1. Restart terminal or run `exec zsh`
2. Vim plugins auto-install on first launch
3. Tmux plugins: Press `Alt+Space + I` to install
4. Configure machine-specific git settings in `~/.config/git/config.local`

## Updating

Update dotfiles:
```bash
cd ~/.dotfiles && git pull && ./install
```

Update Homebrew packages:
```bash
brewup
```

Update asdf plugins and tools:
```bash
asdfup
asdf install
```

## Custom Functions

Located in `functions/` directory:
- `brewup` - Update all Homebrew packages
- `asdfup` - Update all asdf plugins
- `gitclean` - Remove merged git branches
- `mkcd` - Create directory and cd into it
