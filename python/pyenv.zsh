export PYENV_ROOT=$XDG_DATA_HOME/pyenv

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

if (( $+commands[rbenv] )); then eval "$(pyenv init -)"; fi
