return {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      vim.keymap.set("n", "<leader>m", "<cmd>Mason<CR>", { desc = "Open Mason" })
    end
}
