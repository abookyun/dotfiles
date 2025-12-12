return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
}
