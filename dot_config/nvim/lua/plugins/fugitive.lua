return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gdiff", "Gblame", "Glog" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    { "<leader>gd", "<cmd>Gdiff<cr>", desc = "Git diff" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    { "<leader>gl", "<cmd>Glog<cr>", desc = "Git log" },
  },
}
