# Environment variables that external programs read, so they have to be set for
# every shell, not just an interactive one. .zshenv sources this file.
#
# What belongs here: anything a program picks up from the environment. git
# reading EDITOR, python reading PYTHONSTARTUP. A script that calls those tools
# needs them as much as a terminal does.
#
# What does not: interactive settings (setopt, bindkey, aliases) go in .zshrc,
# and PATH goes in .zprofile.
#
# asdf.zsh holds the same kind of exports but stays separate: the chezmoi
# install script sources it with bash.

export LC_ALL=en_US.UTF-8

# vim
export EDITOR='nvim'
export VISUAL='nvim'

# node and npm
# NPM_CONFIG_USERCONFIG and NPM_CONFIG_CACHE are in asdf.zsh, which the chezmoi
# install script sources too.
export NODE_REPL_HISTORY=$XDG_STATE_HOME/node/node_repl_history

# python
# There is no PYTHONHISTFILE here because python does not read one:
# python/pythonrc builds the history path from XDG_STATE_HOME itself.
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONUSERBASE=$XDG_DATA_HOME/python

# uv (fast Python package installer)
export UV_TOOL_DIR=$XDG_DATA_HOME/uv/tools
export UV_TOOL_BIN_DIR=$XDG_DATA_HOME/uv/bin
export UV_CACHE_DIR=$XDG_CACHE_HOME/uv

# less
export LESSHISTFILE="${XDG_STATE_HOME}/zsh/lesshst"

# ruby
# BUNDLE_USER_* are in asdf.zsh.
export IRBRC="$XDG_CONFIG_HOME/ruby/irbrc"

# other tools reading their config from the environment
export TEALDEER_CONFIG_DIR=${XDG_CONFIG_HOME}/tealdeer
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
