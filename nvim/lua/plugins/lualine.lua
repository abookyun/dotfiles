return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1,
            file_status = true,
          }
        }
      }
    })
  end,
}
