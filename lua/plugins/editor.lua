return {
  -- 1. Snacks (Explorer, Terminal, Git, Notifications)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      explorer = { enabled = true },
      lazygit = { enabled = true },
      terminal = { enabled = true },
      notifier = { enabled = true },
      dashboard = { enabled = true }, -- Optional: Gives you the start screen
      indent = { enabled = true },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<c-y>"] = { "confirm", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["<c-y>"] = { "confirm", mode = { "n", "i" } },
            },
          },
        },
      },
    },
    keys = {
      -- Picker
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Go to Definition",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "Go to References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Go to Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Go to Type Definition",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      -- File Explorer
      {
        "<leader>e",
        function()
          require("snacks").explorer()
        end,
        desc = "File Explorer",
      },

      -- Terminal
      {
        "<leader>t",
        function()
          require("snacks").terminal()
        end,
        desc = "Toggle Terminal",
      },

      -- Git
      {
        "<leader>gg",
        function()
          require("snacks").lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gb",
        function()
          require("snacks").git.blame_line()
        end,
        desc = "Git Blame Line",
      },

      -- Notifications
      {
        "<leader>n",
        function()
          require("snacks").notifier.show_history()
        end,
        desc = "Notification History",
      },
    },
  },

  -- 3. Which-Key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>s", group = "search" },
        { "<leader>d", group = "debug" },
      },
    },
  },

  -- 4. Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}
