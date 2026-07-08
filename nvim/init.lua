-- 1. UI & Line Numbers
vim.g.loaded_python3_provider = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "
vim.opt.clipboard:append("unnamedplus")

vim.api.nvim_create_user_command("ReloadConfig", function()
  for _, name in ipairs({
    "config.plugins",
    "config.lsp",
    "config.keymaps",
  }) do
    package.loaded[name] = nil
  end
  dofile(vim.env.MYVIMRC)
end, { desc = "Reload Neovim config" })

vim.keymap.set("n", "<leader>sr", "<cmd>ReloadConfig<cr>", { desc = "Reload config" })

-- Mason bin PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- 2. Plugin Manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("config.plugins"))

-- 3. Theme
vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")

require("config.lsp")
require("config.keymaps")
