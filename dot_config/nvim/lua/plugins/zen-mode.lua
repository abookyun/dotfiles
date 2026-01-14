return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
  },
  config = function()
    require("zen-mode").setup({
      plugins = {
        twilight = { enabled = true },
      },
    })
  end,
}
