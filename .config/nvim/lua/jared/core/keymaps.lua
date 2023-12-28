local keymap = vim.keymap.set

vim.g.mapleader = " "

-- Normal mode
keymap("n", "<leader>qa", ":qa<CR>", { desc = "Quit all neovim" })
keymap("n", "<leader>l", ":Lazy<CR>")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<leader>ss", ":w<CR>")

-- Insert mode
keymap("i", "kj", "<Esc>")
