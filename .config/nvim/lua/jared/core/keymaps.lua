local keymap = vim.keymap.set

vim.g.mapleader = " "

-- Normal mode
keymap("n", "<leader>pf", ":Ex<CR>")
keymap("n", "<leader>qq", ":qa<CR>")
keymap("n", "<leader>l", ":Lazy<CR>")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Insert mode
keymap("i", "kj", "<Esc>")
