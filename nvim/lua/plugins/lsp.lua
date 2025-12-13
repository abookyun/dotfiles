-- LSP Configuration for Neovim 0.11+
-- Using native vim.lsp.config API (no plugin dependency needed)

-- Global border style for floating windows
local border = "double" -- single, double, solid, shadow, rounded

-- Custom diagnostic signs and float border
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "⚠",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "ℹ",
    },
  },
  float = { border = border },
})

-- LSP floating windows border (hover, signature help, etc.)
local orig_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_open_floating_preview(contents, syntax, opts, ...)
end

-- Auto-show diagnostic float after CursorHold (idle for updatetime ms)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float({ focusable = false })
  end,
})

-- LspAttach autocmd for custom keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[e", function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set("n", "]e", function() vim.diagnostic.jump({ count = 1 }) end, opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>F", function() require("conform").format() end, opts)
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

-- Enable all configured LSP servers
vim.lsp.enable({ "lua_ls", "basedpyright", "ruby_lsp", "vimls" })

-- Return empty table (no plugin dependency needed for native LSP)
return {}
