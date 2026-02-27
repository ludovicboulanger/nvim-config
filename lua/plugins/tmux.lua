return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux navigate left" },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Tmux navigate down" },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Tmux navigate up" },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux navigate right" },
    { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Tmux navigate previous" },
  },
}
