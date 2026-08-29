-- Autocommands

-- Return to last cursor position when reopening file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Dynamic smartcase: disable smartcase in command line for easier substitution
vim.api.nvim_create_autocmd("CmdLineEnter", {
  pattern = ":",
  callback = function()
    vim.opt.smartcase = false
  end,
})

vim.api.nvim_create_autocmd("CmdLineLeave", {
  pattern = ":",
  callback = function()
    vim.opt.smartcase = true
  end,
})

-- Python 4-space indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- TCSS (Textual CSS) - use CSS syntax highlighting
vim.filetype.add({
  extension = {
    tcss = "css"
  }
})

-- Markdown: spell check and soft wrap
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us,cjk"

    -- Soft wrap: fold visually, never insert hard line breaks
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true   -- break at word boundaries, not mid-word
    vim.opt_local.breakindent = true -- keep list/quote indentation on wrapped lines
    vim.opt_local.showbreak = "↳ "
    vim.opt_local.textwidth = 0      -- no auto hard-wrap while typing

    -- Move by screen line on wrapped lines, but keep a count (3j) on real
    -- lines so it still matches the relative line numbers in the gutter.
    local function map(lhs, rhs)
      vim.keymap.set({ "n", "x" }, lhs, rhs, { buffer = true, expr = true, silent = true })
    end
    map("j", "v:count == 0 ? 'gj' : 'j'")
    map("k", "v:count == 0 ? 'gk' : 'k'")
    map("0", "v:count == 0 ? 'g0' : '0'")
    map("$", "v:count == 0 ? 'g$' : '$'")
  end,
})
