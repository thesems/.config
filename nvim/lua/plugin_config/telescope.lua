require('telescope').setup({})
require("telescope").load_extension("undo")

vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
