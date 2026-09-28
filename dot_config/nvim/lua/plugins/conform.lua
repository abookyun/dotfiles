return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        python = { "ruff_format" },
        rust = { "rustfmt" },
        toml = { "taplo" },
      },
      -- TOML is format on demand only (<leader>F). Many projects do not use
      -- taplo, so a save would add style changes to their files.
      format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype == "toml" then
          return
        end
        return { timeout_ms = 500 }
      end,
    })
  end,
}
