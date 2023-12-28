return {
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>m", "<cmd>Mason<CR>", desc = "Open Mason" }
    },
    config = true
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "tsserver"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})

      local keymap = vim.keymap.set
      keymap('n', 'K', vim.lsp.buf.hover)
    end
  }
}
