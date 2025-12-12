return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

    -- Custom diagnostic signs (uncomment to enable)
    -- local signs = { Error = "✘", Warn = "⚠", Hint = "⚑", Info = "ℹ" }
    -- for type, icon in pairs(signs) do
    --   local hl = "DiagnosticSign" .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    -- end

    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<leader>F", function() require("conform").format() end, opts)
    end

    lspconfig.lua_ls.setup({ on_attach = on_attach })
    lspconfig.basedpyright.setup({ on_attach = on_attach })
    lspconfig.ruby_lsp.setup({ on_attach = on_attach })
    lspconfig.vimls.setup({ on_attach = on_attach })
  end,
}
