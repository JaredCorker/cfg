local keymap = vim.keymap.set

vim.g.mapleader = " "

-- Normal mode
keymap("n", "<leader>pf", ":Ex<CR>")
keymap("n", "<leader>qq", ":qa<CR>")
keymap("n", "<leader>l", ":Lazy<CR>")

-- Insert mode
keymap("i", "kj", "<Esc>")
