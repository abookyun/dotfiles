# zsh exports
export LC_ALL=en_US.UTF-8

HISTFILE=${XDG_STATE_HOME}/zsh/zsh_history
HISTSIZE=10000
SAVEHIST=10000
SHELL_SESSIONS_DISABLE=1

# vim
export EDITOR='vim'
export VISUAL='vim'
export MY_VIM_CONFIG_DIR="${XDG_CONFIG_HOME}/vim"
export MY_VIM_DATA_DIR="${XDG_DATA_HOME}/vim"
export MY_VIM_STATE_DIR="${XDG_STATE_HOME}/vim"

# node and npm
export NODE_REPL_HISTORY=$XDG_STATE_HOME/node/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config

# less
export LESSHISTFILE="${XDG_STATE_HOME}/zsh/lesshst"

# zsh settings
setopt AUTOCD
setopt AUTO_LIST
setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST
setopt IGNORE_EOF

# Directory Stack
setopt AUTO_PUSHD # push the current directory visited on the stack
setopt PUSHD_IGNORE_DUPS # do not store duplicates in the stack
setopt PUSHD_SILENT # do not print the directory stack after pushd or popd

# Completion
setopt LIST_PACKED
setopt COMPLETE_IN_WORD

# History
setopt APPEND_HISTORY # adds history
setopt SHARE_HISTORY # share history between sessions
setopt EXTENDED_HISTORY # add timestamps to history
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

# zsh key binding
# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

bindkey -v
export KEYTIMEOUT=1
