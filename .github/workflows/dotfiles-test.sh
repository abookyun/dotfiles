#!/bin/bash

echo "==== Check XDG-related environment variables and paths ===="

pass_count=0
fail_count=0

test_and_report() {
    desc="$1"
    condition="$2"
    if eval "$condition"; then
        echo "[PASS] $desc"
        ((pass_count++))
    else
        echo "[FAIL] $desc"
        ((fail_count++))
    fi
}

# 1. XDG_CONFIG_HOME
expected_xdg_config_home="${HOME}/.config"
test_and_report "\$XDG_CONFIG_HOME should be $expected_xdg_config_home" '[ "$XDG_CONFIG_HOME" = "'"$expected_xdg_config_home"'" ]'
test_and_report "$expected_xdg_config_home should exist" '[ -d "$expected_xdg_config_home" ]'

# 2. XDG_DATA_HOME
expected_xdg_data_home="${HOME}/.local/share"
test_and_report "\$XDG_DATA_HOME should be $expected_xdg_data_home" '[ "$XDG_DATA_HOME" = "'"$expected_xdg_data_home"'" ]'
test_and_report "$expected_xdg_data_home should exist" '[ -d "$expected_xdg_data_home" ]'

# 3. XDG_STATE_HOME
expected_xdg_state_home="${HOME}/.local/state"
test_and_report "\$XDG_STATE_HOME should be $expected_xdg_state_home" '[ "$XDG_STATE_HOME" = "'"$expected_xdg_state_home"'" ]'
test_and_report "$expected_xdg_state_home should exist" '[ -d "$expected_xdg_state_home" ]'

# 4. XDG_CACHE_HOME
expected_xdg_cache_home="${HOME}/.local/cache"
test_and_report "\$XDG_CACHE_HOME should be $expected_xdg_cache_home" '[ "$XDG_CACHE_HOME" = "'"$expected_xdg_cache_home"'" ]'
test_and_report "$expected_xdg_cache_home should exist" '[ -d "$expected_xdg_cache_home" ]'

# 5. ZDOTDIR
expected_zdotdir="${XDG_CONFIG_HOME}/zsh"
test_and_report "\$ZDOTDIR should be $expected_zdotdir" '[ "$ZDOTDIR" = "'"$expected_zdotdir"'" ]'
test_and_report "$expected_zdotdir should exist" '[ -d "$expected_zdotdir" ]'

# 6. VIMINIT
expected_vimrc='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
test_and_report "\$VIMINIT should be $expected_vimrc" '[ "$VIMINIT" = "$expected_vimrc" ]'

# 7. $XDG_CONFIG_HOME/zsh/.zshrc symlink to .dotfiles/zsh/zshrc check
zshrc_path="$XDG_CONFIG_HOME/zsh/.zshrc"
dotfiles_zshrc_path="$PWD/zsh/zshrc"
test_and_report "$zshrc_path should exist" '[ -e "$zshrc_path" ]'
test_and_report "$zshrc_path should be a symbolic link" '[ -L "$zshrc_path" ]'
if [ -L "$zshrc_path" ]; then
    link_target="$(readlink -f "$zshrc_path")"
    test_and_report "$zshrc_path should link to $dotfiles_zshrc_path" '[ "$link_target" = "'"$dotfiles_zshrc_path"'" ]'
fi

# 8. $XDG_CONFIG_HOME/vim/vimrc symlink to .dotfiles/vim/vimrc
vimrc_path="$XDG_CONFIG_HOME/vim/vimrc"
dotfiles_vimrc_path="$PWD/vim/vimrc"
test_and_report "$vimrc_path should exist" '[ -e "$vimrc_path" ]'
test_and_report "$vimrc_path should be a symbolic link" '[ -L "$vimrc_path" ]'
if [ -L "$vimrc_path" ]; then
    link_target="$(readlink -f "$vimrc_path")"
    test_and_report "$vimrc_path should link to $dotfiles_vimrc_path" '[ "$link_target" = "'"$dotfiles_vimrc_path"'" ]'
fi

# 9. $XDG_CONFIG_HOME/git/config symlink to .dotfiles/git/config
gitconfig_path="$XDG_CONFIG_HOME/git/config"
dotfiles_gitconfig_path="$PWD/git/config"
test_and_report "$gitconfig_path should exist" '[ -e "$gitconfig_path" ]'
test_and_report "$gitconfig_path should be a symbolic link" '[ -L "$gitconfig_path" ]'
if [ -L "$gitconfig_path" ]; then
    link_target="$(readlink -f "$gitconfig_path")"
    test_and_report "$gitconfig_path should link to $dotfiles_gitconfig_path" '[ "$link_target" = "'"$dotfiles_gitconfig_path"'" ]'
fi

# 10. $XDG_CONFIG_HOME/tmux/tmux.conf symlink to .dotfiles/tmux/tmux.conf
tmuxconf_path="$XDG_CONFIG_HOME/tmux/tmux.conf"
dotfiles_tmuxconf_path="$PWD/tmux/tmux.conf"
test_and_report "$tmuxconf_path should exist" '[ -e "$tmuxconf_path" ]'
test_and_report "$tmuxconf_path should be a symbolic link" '[ -L "$tmuxconf_path" ]'
if [ -L "$tmuxconf_path" ]; then
    link_target="$(readlink -f "$tmuxconf_path")"
    test_and_report "$tmuxconf_path should link to $dotfiles_tmuxconf_path" '[ "$link_target" = "'"$dotfiles_tmuxconf_path"'" ]'
fi

# 11. $XDG_CONFIG_HOME/asdf/asdfrc symlink to .dotfiles/asdf/asdfrc
asdfrc_path="$XDG_CONFIG_HOME/asdf/asdfrc"
dotfiles_asdfrc_path="$PWD/asdf/asdfrc"
test_and_report "$asdfrc_path should exist" '[ -e "$asdfrc_path" ]'
test_and_report "$asdfrc_path should be a symbolic link" '[ -L "$asdfrc_path" ]'
if [ -L "$asdfrc_path" ]; then
    link_target="$(readlink -f "$asdfrc_path")"
    test_and_report "$asdfrc_path should link to $dotfiles_asdfrc_path" '[ "$link_target" = "'"$dotfiles_asdfrc_path"'" ]'
fi

# 12. Check asdf installation
test_and_report "'asdf' should be installed and executable" 'command -v asdf >/dev/null 2>&1'

# 13. Check brew installation
test_and_report "'brew' should be installed and executable" 'command -v brew >/dev/null 2>&1'

# 14. Check tpm (Tmux Plugin Manager) installation
tpm_dir="$XDG_DATA_HOME/tmux/plugins/tpm"
test_and_report "tpm (Tmux Plugin Manager) should be installed at $tpm_dir" '[ -d "$tpm_dir" ]'

echo "==== Test finished ===="
echo "Passed: $pass_count, Failed: $fail_count"
exit $fail_count
