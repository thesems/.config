vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set('n', '<leader>q', ':wq!<CR>',{noremap = true})
-- vim.keymap.set('n', '<F2>', '<cmd>Lexplore<cr>')
-- vim.keymap.set('n', '<space><space>', '<F2>', {remap = true})

vim.opt.termguicolors = true
vim.cmd.colorscheme('kanagawa')
