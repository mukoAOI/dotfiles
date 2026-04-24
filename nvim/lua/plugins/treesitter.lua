return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUpdate", "TSUninstall", "TSLog" },
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
      -- 首次可手动执行 :TSInstall rust zig

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }

      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#e67e80" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#d9bb80" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#7fbbb3" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#e69875" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#a7c080" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#d699b6" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#83c092" })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4261", nocombine = true })
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7", nocombine = true })
      end)

      return {
        indent = {
          char = "▏",
          tab_char = "▏",
          highlight = "IblIndent",
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = "IblScope",
          include = {
            node_type = {
              lua = { "table", "block" },
            },
          },
        },
        whitespace = {
          remove_blankline_trail = true,
        },
        exclude = {
          filetypes = {
            "dashboard",
            "packer",
            "terminal",
            "help",
            "log",
            "markdown",
            "TelescopePrompt",
            "lsp-installer",
            "lspinfo",
            "toggleterm",
            "lazy",
            "mason",
            "NvimTree",
            "alpha",
          },
          buftypes = { "terminal", "nofile", "quickfix", "prompt" },
        },
      }
    end,
    main = "ibl",
  },
}
