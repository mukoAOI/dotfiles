return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      transparent = true,
      theme = "wave",
      overrides = function(colors)
        local p = colors.palette
        return {
          ["@keyword"] = { fg = p.surimiOrange, bold = true },
          ["@type"] = { fg = p.carpYellow, bold = true },
          ["@function"] = { fg = p.crystalBlue, bold = true },
          ["@method"] = { fg = p.crystalBlue, bold = true },
          ["@string"] = { fg = p.springGreen },
          ["@constant"] = { fg = p.oniViolet, bold = true },
          ["@property"] = { fg = p.waveAqua2 },
          ["@variable.member"] = { fg = p.waveAqua2 },
          ["@parameter"] = { fg = p.springViolet1 },
          WinSeparator = { fg = "#ffd866", bg = "NONE", bold = true },
          VertSplit = { fg = "#ffd866", bg = "NONE", bold = true },
          LineNr = { fg = "#ffd866", bg = "NONE" },
          CursorLineNr = { fg = "#ffffff", bg = "NONE", bold = true },
          SignColumn = { fg = "#ffd866", bg = "NONE" },
          FoldColumn = { fg = "#ffd866", bg = "NONE" },
        }
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa")
    end,
  },
}
