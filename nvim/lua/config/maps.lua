-- leader
map("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- C-o to exit insert in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TerminalExitInsertCustomMap", {}),
  pattern = "*",
  command = [[tnoremap <buffer> <C-o> <C-\><C-n>]],
})

-- toggle neo tree
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

--delete buffer
vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete<CR>")
--open window horizantally
vim.keymap.set("n", "<leader>w|", "<Cmd>Neotree toggle<CR>")

-- Why, why, why
map("n", "Y", "y$")

-- Keeping it center
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

-- Jumplist mutations
map("n", "j", [[(v:count >= 5 ? "m'" . v:count : "") . "j"]], { expr = true })
map("n", "k", [[(v:count >= 5 ? "m'" . v:count : "") . "k"]], { expr = true })