return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  config = function()
    -- Same ctrl+hjkl inside herdr. vim loads this file from its own plugin/ dir.
    local config_home = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
    vim.cmd.source(config_home .. "/vim/plugin/herdr_navigator.vim")
  end,
}
