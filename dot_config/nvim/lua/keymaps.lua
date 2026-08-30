-- Keymaps
vim.g.mapleader = " "

local keymap = vim.keymap.set

-- System clipboard
-- Normal mode takes a motion: <leader>yy for a line, <leader>yw for a word
keymap("n", "<leader>y", '"+y', { desc = "Yank to clipboard (takes a motion)" })
keymap("v", "<leader>y", '"+y', { desc = "Yank selection to clipboard" })
keymap("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
-- Replaces the selection, and unlike plain p it leaves the register alone
keymap("v", "<leader>p", '"+p', { desc = "Paste over selection" })

-- Window split
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
keymap("n", "<leader>sc", ":close<CR>", { desc = "Close split" })

-- Window maximize/restore
keymap("n", "<leader>sm", "<C-w>_<C-w>|", { desc = "Maximize split" })

-- Window swap/rotate
keymap("n", "<leader>sr", "<C-w>r", { desc = "Rotate splits" })
keymap("n", "<leader>sx", "<C-w>x", { desc = "Swap split" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Window left" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Window down" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Window up" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Move lines in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down, centered" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up, centered" })
keymap("n", "n", "nzzzv", { desc = "Next search match, centered" })
keymap("n", "N", "Nzzzv", { desc = "Previous search match, centered" })

-- Quick save/quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Write" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Buffer navigation
keymap("n", "<leader>1", "<cmd>bfirst<cr>", { desc = "First buffer" })
keymap("n", "<leader>]", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>[", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap("n", "<leader>9", "<cmd>blast<cr>", { desc = "Last buffer" })
keymap("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Diagnostics, matching ALE's [e/]e/[E/]E in the vim config
keymap("n", "[e", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
keymap("n", "]e", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
keymap("n", "[E", function() vim.diagnostic.jump({ count = -math.huge, wrap = false }) end, { desc = "First diagnostic" })
keymap("n", "]E", function() vim.diagnostic.jump({ count = math.huge, wrap = false }) end, { desc = "Last diagnostic" })

-- Folding
keymap("n", "<leader>=", "za", { desc = "Toggle fold" })
keymap("n", "<leader>+", "zR", { desc = "Open all folds" })
keymap("n", "<leader>_", "zM", { desc = "Close all folds" })
keymap("v", "<leader>=", "za", { desc = "Toggle fold" })
keymap("v", "<leader>+", "zR", { desc = "Open all folds" })
keymap("v", "<leader>_", "zM", { desc = "Close all folds" })
