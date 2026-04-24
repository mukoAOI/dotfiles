return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Terminal Toggle" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
      { "<leader>th", "<cmd>ToggleTerm size=12 direction=horizontal<cr>", desc = "Terminal Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Terminal Vertical" },
    },
    opts = {
      start_in_insert = true,
      direction = "float",
      float_opts = {
        border = "rounded",
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Debug Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Debug Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Debug Step Out" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug UI Toggle" },
    },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
      })

      dapui.setup()
      require("nvim-dap-virtual-text").setup({})

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local ok, registry = pcall(require, "mason-registry")
      if ok and registry.has_package("codelldb") then
        local pkg = registry.get_package("codelldb")
        local install_path = pkg:get_install_path()
        local adapter = install_path .. "/extension/adapter/codelldb.exe"
        local liblldb = install_path .. "/extension/lldb/bin/liblldb.dll"
        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = adapter,
            args = { "--port", "${port}" },
            detached = false,
          },
        }

        for _, lang in ipairs({ "c", "cpp", "rust", "zig" }) do
          dap.configurations[lang] = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              args = {},
              initCommands = {
                "command script import '" .. liblldb .. "'",
              },
            },
          }
        end
      end
    end,
  },

  {
    "nvim-neotest/neotest",
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Test Nearest" },
      { "<leader>tF", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test File" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test Debug Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Test Output" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python"),
          require("neotest-rust"),
        },
      })
    end,
  },
}
