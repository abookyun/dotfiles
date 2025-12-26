-- Keymaps
vim.g.mapleader = " "

local keymap = vim.keymap.set

-- System clipboard
keymap("n", "<leader>y", '"+y')
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>p", '"+p')
keymap("n", "<leader>P", '"+P')

-- Window split
keymap("n", "<leader>sv", "<C-w>v")
keymap("n", "<leader>sh", "<C-w>s")
keymap("n", "<leader>se", "<C-w>=")
keymap("n", "<leader>sc", ":close<CR>")

-- Window maximize/restore
keymap("n", "<leader>sm", "<C-w>_<C-w>|")

-- Window swap/rotate
keymap("n", "<leader>sr", "<C-w>r")
keymap("n", "<leader>sx", "<C-w>x")

-- Window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Move lines in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Quick save/quit
keymap("n", "<leader>w", ":w<CR>")
keymap("n", "<leader>q", ":q<CR>")

-- Buffer navigation
keymap("n", "<leader>1", "<cmd>bfirst<cr>", { desc = "First buffer" })
keymap("n", "<leader>]", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>[", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap("n", "<leader>9", "<cmd>blast<cr>", { desc = "Last buffer" })
keymap("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Folding
keymap("n", "<leader>=", "za", { desc = "Toggle fold" })
keymap("n", "<leader>+", "zR", { desc = "Open all folds" })
keymap("n", "<leader>_", "zM", { desc = "Close all folds" })
keymap("v", "<leader>=", "za", { desc = "Toggle fold" })
keymap("v", "<leader>+", "zR", { desc = "Open all folds" })
keymap("v", "<leader>_", "zM", { desc = "Close all folds" })
