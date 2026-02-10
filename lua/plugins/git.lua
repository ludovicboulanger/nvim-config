return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    -- Customize the symbols in the gutter
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    -- Highlight the line number instead of the sign column (optional)
    numhl = false,
    -- Toggle line highlighting (optional)
    linehl = false,
    -- Toggle word diff highlighting (optional)
    word_diff = false,

    -- Keymaps Setup
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation (Jump between changes)
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Next Hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Prev Hunk" })

      -- Actions
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
      map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame Line" })
      map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })
    end,
  },
}
