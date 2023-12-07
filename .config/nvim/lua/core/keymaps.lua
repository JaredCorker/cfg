local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("i", "kj", "<Esc>")
keymap("n", "<leader>pf", ":Ex<CR>")

keymap("n", "<leader>l", ":Lazy<CR>")

keymap("n", "<leader>qq", ":qa<CR>")
