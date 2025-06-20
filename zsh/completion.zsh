# zsh completions

# homebrew completion: https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
_comp_options+=(globdots) # With hidden files
# compaudit | xargs chmod g-w
# https://unix.stackexchange.com/questions/383365/zsh-compinit-insecure-directories-run-compaudit-for-list
compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump-$ZSH_VERSION-by-$(whoami)
# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' menu select
# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
