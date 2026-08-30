return {
  "folke/trouble.nvim",
  opts = {
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>Dd",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>DD",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>Dq",
      "<cmd>Trouble quickfix toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
    {
      "<leader>Dl",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
  },
}
