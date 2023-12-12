-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("jared.core.options")
require("jared.core.keymaps")

require("jared.lazy-setup")
require("lazy").setup("jared.plugins")
