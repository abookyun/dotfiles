#!/usr/bin/env bash

# install tpm for tmux
MY_TPM_DIR="${XDG_DATA_HOME}/tmux/plugins/tpm"
[[ -d $MY_TPM_DIR ]] || git clone https://github.com/tmux-plugins/tpm ${MY_TPM_DIR}

