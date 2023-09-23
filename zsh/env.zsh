export LC_ALL=en_US.UTF-8

# vim
export EDITOR='vim'
export VISUAL='vim'
export MY_VIM_CONFIG_DIR="${XDG_CONFIG_HOME}/vim"
if ! [ -d $MY_VIM_CONFIG_DIR ]; then mkdir -p $MY_VIM_CONFIG_DIR; fi
export MY_VIM_DATA_DIR="${XDG_DATA_HOME}/vim"
if ! [ -d $MY_VIM_DATA_DIR ]; then mkdir -p $MY_VIM_DATA_DIR; fi
export MY_VIM_STATE_DIR="${XDG_STATE_HOME}/vim"
if ! [ -d $MY_VIM_STATE_DIR ]; then mkdir -p $MY_VIM_STATE_DIR; fi


mkdir -p ${XDG_STATE_HOME}/zsh
HISTFILE=${XDG_STATE_HOME}/zsh/zsh_history
HISTSIZE=10000
SAVEHIST=10000
SHELL_SESSIONS_DISABLE=1

# less
export LESSHISTFILE="${XDG_STATE_HOME}/less/lesshst"
mkdir -p $(dirname $LESSHISTFILE)
