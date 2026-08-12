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
    })

    local function try_attach(buf)
      local ok = pcall(vim.treesitter.start, buf)
      if ok then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(args)
        try_attach(args.buf)
      end,
    })

    try_attach(vim.api.nvim_get_current_buf())
  end,
}
