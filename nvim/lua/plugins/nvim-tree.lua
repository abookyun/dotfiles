return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    { "<leader>o", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in tree" },
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
