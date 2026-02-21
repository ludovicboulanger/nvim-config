return {
  -- 1. Mason (The Tool Manager)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { "debugpy", "stylua" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      -- Auto-install tools (safely)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- 2. Blink (Autocompletion)
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },
      appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = "mono" },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      signature = { enabled = true },
    },
  },

  -- 3. LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local util = require("lspconfig.util") -- still valid for root_pattern

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff", "lua_ls" },
      })

      -- Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- Ruff (lint + fixes)
      vim.lsp.config("ruff", {
        capabilities = capabilities,
        root_markers = { "pyproject.toml", "requirements.txt", ".git" },
      })
      vim.lsp.enable("ruff")

      -- Pyright (types only)
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",

              -- Let Ruff Handle these
              reportUnusedImport = "none",
              reportUnusedVariable = "none",
              reportUnusedFunction = "none",
              reportUnusedClass = "none",
            },
          },
        },
      })
      vim.lsp.enable("pyright")
    end,
  },
  -- 4. Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        python = {
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
        },
        lua = { "stylua" },
      },
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
      },
      format_on_save = { timeout_ms = 3000, lsp_fallback = false },
    },
  },

  -- 5. Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap-python" },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start / Continue",
      },
      -- NEW KEYS FOR STEPPING:
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate Session",
      },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 }, -- Variables
              { id = "breakpoints", size = 0.25 }, -- List of active breakpoints
              { id = "stacks", size = 0.25 }, -- Call stack
              { id = "watches", size = 0.25 }, -- <--- HERE IS THE WATCH TAB
            },
            size = 40, -- Width of the sidebar
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25,
            position = "bottom",
          },
        },
      })
      -- 1. Open immediately when we start
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.launch["dapui_config"] = function()
        dapui.open()
      end
      -- 2. FORCE Open when we hit a breakpoint or finish a step
      dap.listeners.before.event_stopped["dapui_config"] = function()
        dapui.open()
      end
      -- 3. Close ONLY when the session is completely dead
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy"
      if vim.loop.fs_stat(mason_path) then
        local venv = (vim.fn.has("win32") == 1) and "/venv/Scripts/python.exe" or "/venv/bin/python"
        require("dap-python").setup(mason_path .. venv)
      end
    end,
  },
}
