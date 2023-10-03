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
