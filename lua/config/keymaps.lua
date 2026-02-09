local map = vim.keymap.set

-- Better window navigation
map({ "n", "t" }, "<C-h>", "<C-w>h", { desc = "Move to left window" })
map({ "n", "t" }, "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map({ "n", "t" }, "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map({ "n", "t" }, "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize window using <ctrl> arrow keys
map({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Buffer (Tab) Navigation
-- Shift + H to go left
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- Shift + L to go right
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Close current buffer with <leader>bd (optional, but very useful)
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit Terminal Mode" })

-- While in terminal mode, use these to navigate windows directly
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go Down Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go Up Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go Right Window" })
