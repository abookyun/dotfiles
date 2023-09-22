export LC_ALL=en_US.UTF-8

export EDITOR='vim'
export VISUAL='vim'

mkdir -p ${XDG_STATE_HOME}/zsh
HISTFILE=${XDG_STATE_HOME}/zsh/zsh_history
HISTSIZE=10000
SAVEHIST=10000
SHELL_SESSIONS_DISABLE=1

# less
export LESSHISTFILE="${XDG_STATE_HOME}/less/lesshst"
mkdir -p $(dirname $LESSHISTFILE)
