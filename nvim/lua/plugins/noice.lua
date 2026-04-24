return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- 核心设置
      lsp = {
        -- 覆盖 LSP 的签名助手和文档悬浮窗
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- 预设设置：启用所有现代 UI 特性
      presets = {
        bottom_search = true,    -- 搜索栏移到屏幕底部（可选）
        command_palette = true,  -- 命令输入框显示在屏幕中间
        long_message_to_split = true, -- 长消息自动拆分
        inc_rename = false,      -- 如果没装 inc-rename 插件就设为 false
        lsp_doc_border = true,   -- 为 LSP 文档添加边框
      },
      -- 视觉优化：调整浮动窗样式
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    },
    dependencies = {
      -- 必须依赖
      "MunifTanjim/nui.nvim",
      -- 可选：用于显示美观的通知弹窗
      "rcarriga/nvim-notify",
    }
  }
}