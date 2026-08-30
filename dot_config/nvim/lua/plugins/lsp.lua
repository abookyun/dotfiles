-- LSP Configuration for Neovim 0.11+
-- Using native vim.lsp.config API (no plugin dependency needed)

-- Border style for every floating window: hover, signature help,
-- diagnostics, and any plugin that does not ask for one of its own.
-- single, double, solid, shadow, rounded
vim.o.winborder = "double"

-- Custom diagnostic signs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "⚠",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "ℹ",
    },
  },
})

-- Drop the built-in gr* LSP maps (0.11+). Two reasons:
--
-- 1. They make "gr" ambiguous. Our own gr is a prefix of grr/gra/gri/grn/grt,
--    so nvim waits out 'timeoutlen' on every press to see if a second key is
--    coming. Removing them makes gr fire immediately.
-- 2. The vim config drives the same commands through ALE on gd/gD/gr/gi, and
--    plain vim has no gr* maps at all, so this keeps both editors identical.
--
-- Every one of them already has a shorter binding below, except grx
-- (codelens), which moves to <leader>cl.
for _, key in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx" }) do
  pcall(vim.keymap.del, "n", key)
end
pcall(vim.keymap.del, "x", "gra")
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run codelens" })

-- LspAttach autocmd for custom keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.type_definition, "Go to type definition")
    map("gr", vim.lsp.buf.references, "References")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("K", vim.lsp.buf.hover, "Hover docs")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>d", vim.diagnostic.open_float, "Show diagnostic")
    map("<leader>F", function() require("conform").format() end, "Format buffer")

    -- Inferred types and parameter names, where the server offers them
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      map("<leader>H", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
      end, "Toggle inlay hints")
    end

    -- Paint colour literals in their own colour (cssls)
    if client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, { bufnr = args.buf })
    end
  end,
})

-- Default config for all LSP servers
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Lua (with Neovim runtime support)
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Python
vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
  settings = {
    basedpyright = {
      typeCheckingMode = "recommended",
      reportGeneralTypeIssues = true,
      reportUnusedImport = false,
      reportUnusedVariable = false,
    },
  },
})

-- CSS (.tcss files are mapped to the css filetype in autocmds.lua)
vim.lsp.config("cssls", {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css" },
  root_markers = { ".git" },
})

-- Ruby
vim.lsp.config("ruby_lsp", {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".ruby-version", ".git" },
})

-- Vim
vim.lsp.config("vimls", {
  cmd = { "vim-language-server", "--stdio" },
  filetypes = { "vim" },
})

-- Harper (prose linter)
vim.lsp.config("harper_ls", {
  cmd = { "harper-ls", "--stdio" },
  -- "plaintext" is VS Code's name for this; Vim calls it "text"
  filetypes = { "markdown", "text", "rst", "asciidoc", "gitcommit" },
})

-- Enable all configured LSP servers
vim.lsp.enable({ "lua_ls", "basedpyright", "cssls", "ruby_lsp", "vimls", "harper_ls" })

-- Return empty table (no plugin dependency needed for native LSP)
return {}
