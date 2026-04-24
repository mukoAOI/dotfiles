return {
  {
    "romgrk/barbar.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbar").setup({
        animation = false,
        auto_hide = false,
        clickable = true,
        insert_at_end = true,
        semantic_letters = true,
        sidebar_filetypes = {
          NvimTree = true,
        },
        icons = {
          buffer_index = false,
          buffer_number = false,
          separator_at_end = false,
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = false },
            [vim.diagnostic.severity.WARN] = { enabled = false },
            [vim.diagnostic.severity.INFO] = { enabled = false },
            [vim.diagnostic.severity.HINT] = { enabled = false },
          },
          filetype = {
            enabled = true,
            custom_colors = false,
          },
          separator = { left = "▎", right = "" },
          inactive = { separator = { left = "▎", right = "" } },
          current = { button = "■" },
          visible = { modified = { buffer_number = false } },
          button = "■",
        },
      })

      vim.keymap.set("n", "H", "<cmd>BufferPrevious<cr>", { desc = "Prev Buffer" })
      vim.keymap.set("n", "L", "<cmd>BufferNext<cr>", { desc = "Next Buffer" })
      vim.keymap.set("n", "<leader>c", "<cmd>BufferClose<cr>", { desc = "Close Buffer" })
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferPick<cr>", { desc = "Pick Buffer" })
      vim.keymap.set("n", "<leader>bo", "<cmd>BufferCloseAllButCurrent<cr>", { desc = "Close Other Buffers" })
    end,
  },
}
