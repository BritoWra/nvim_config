local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Save file
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
