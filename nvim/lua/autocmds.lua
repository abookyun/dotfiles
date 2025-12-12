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
