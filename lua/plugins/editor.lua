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
    },
    keys = {
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

  -- 2. Fzf-Lua (Search / Fuzzy Finder)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Search Code)" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
    },
    opts = {
      "default-title",
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = { layout = "vertical", vertical = "down:45%" },
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
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = { "python", "lua", "vim", "vimdoc", "bash", "markdown" },
      highlight = { enable = true },
   }
 },
}
