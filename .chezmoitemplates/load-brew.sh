# Put brew on PATH when the calling shell does not have it. chezmoi runs these
# scripts with its own environment, which is not a login shell, so .zprofile
# never ran.
#
# The prefix differs by architecture: /opt/homebrew on Apple Silicon,
# /usr/local on Intel.
load_brew() {
    command -v brew &> /dev/null && return
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

load_brew
