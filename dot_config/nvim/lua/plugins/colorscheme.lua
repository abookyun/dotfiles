return {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('dracula').setup({
      overrides = function(colors)
        return {
          CursorLine = { bg = '#3e4452' },
          Visual = { bg = '#7c7f8a' },
          CursorColumn = { bg = '#3e4452' },
        }
      end,
    })

    vim.cmd("colorscheme dracula")
  end,
}
