vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.nu = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.hidden = true

vim.opt.exrc = true
vim.opt.secure = true

vim.keymap.set("n", "<Enter>", "o<Esc>")
vim.keymap.set("n", "<S-Enter>", "O<Esc>")
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')

-- Disable inline text
vim.diagnostic.config({
  virtual_text = false,
  signs        = true,   -- keep gutter signs
  underline    = true,
  update_in_insert = false,
})

-- Always show the signcolumn
vim.o.signcolumn = "yes"

-- Map <Leader>e (or any key) to show diagnostics in a floating window
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true })

