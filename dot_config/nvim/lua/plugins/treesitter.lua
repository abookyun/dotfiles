return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({})

    -- The main branch dropped ensure_installed; install() is the replacement.
    -- Only request what is missing, so startup does not re-fetch every time.
    local wanted = {
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
      "markdown_inline",
      "rust",
      "sql",
    }
    local installed = {}
    for _, lang in ipairs(ts.get_installed()) do
      installed[lang] = true
    end
    local missing = vim.tbl_filter(function(lang)
      return not installed[lang]
    end, wanted)
    if #missing > 0 then
      ts.install(missing)
    end

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
