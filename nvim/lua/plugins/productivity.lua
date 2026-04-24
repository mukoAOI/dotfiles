return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300,
      preset = "modern",
      spec = {
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>c", group = "Code" },
        { "<leader>s", group = "Search/Jump" },
        { "<leader>d", group = "Debug" },
        { "<leader>t", group = "Terminal/Test" },
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
    },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Git Blame Line" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Git Diff This" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Git Reset Hunk" },
      { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
      { "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev Hunk" },
    },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = false, cpp = false }
        return {
          timeout_ms = 800,
          lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and "never" or "fallback",
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
        zig = { "zigfmt" },
        json = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
    },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Code Format",
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff" },
        lua = { "luacheck" },
        rust = { "clippy" },
        markdown = { "markdownlint" },
      }

      local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function()
          pcall(lint.try_lint)
        end,
      })
    end,
  },
}
