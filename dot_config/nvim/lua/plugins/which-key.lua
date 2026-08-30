return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Labels for the prefixes; the mappings themselves carry their own desc.
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunk" },
      { "<leader>s", group = "split" },
      { "<leader>D", group = "diagnostics (Trouble)" },
      { "<leader>c", group = "code" },
      { "g", group = "goto" },
      { "[", group = "previous" },
      { "]", group = "next" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer local keymaps",
    },
  },
}
