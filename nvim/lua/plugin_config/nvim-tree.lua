require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    git_ignored = false,
    dotfiles = false,
  },
})

vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>')
