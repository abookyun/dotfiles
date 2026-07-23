return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "python",
        "ruby",
        "html",
        "css",
        "json",
        "yaml",
        "bash",
        "markdown",
        "rust",
        "sql",
      },
      highlight = { enable = true },
      indent = { enable = true },
      endwise = { enable = true },
    })
  end,
}
