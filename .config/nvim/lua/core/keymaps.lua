local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("i", "kj", "<Esc>")
keymap("n", "<leader>pf", ":Ex<CR>")
