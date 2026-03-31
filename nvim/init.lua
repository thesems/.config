-- 1. UI & Line Numbers
vim.g.loaded_python3_provider = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.clipboard:append("unnamedplus")

-- Mason bin PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- 2. Plugin Manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Plugins
require("lazy").setup({
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
            ensure_installed = { "lua", "python", "go" }
    }
  },

  -- Telescope (Fuzzy Finder)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = "Telescope",
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Search Text' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        preview = {
            treesitter = false,
        }
      }
    }
  },

  -- File Explorer (Oil.nvim)
  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = 80,
        max_height = 20,
        border = "rounded",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Mason (only for :Mason UI)
  { "williamboman/mason.nvim", cmd = "Mason", opts = {} },

  -- Formatting
  { "stevearc/conform.nvim", event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
            python = { "isort", "black" },
            go = { "goimports", "gofmt" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
      })
    end,
  },

  -- Linting
  { "mfussenegger/nvim-lint", event = "BufWritePost",
    config = function()
      require("lint").linters_by_ft = { 
          python = { "ruff" },
          go = { "golangcilint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function() require("lint").try_lint() end,
      })
    end,
  },

  -- Lazygit Integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
})


-- 4. Theme
vim.o.background = "dark"
vim.cmd.colorscheme "gruvbox"

-- 5. LSP (Neovim 0.11+ native)
vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  single_file_support = true,
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})
vim.lsp.enable("basedpyright")

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
    },
  },
})
vim.lsp.enable("gopls")

-- Native LSP completion
vim.opt.completeopt = "menuone,noselect,popup"
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Oil: Open file explorer
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- 6. Keymaps
-- Neovim 0.11 built-in LSP keymaps (no setup needed):
--   K          hover
--   grn        rename
--   grr        references
--   gri        implementation
--   gra        code action
--   CTRL-]     go to definition
--   CTRL-S     signature help (insert mode)
vim.keymap.set('i', '<C-n>', function() vim.lsp.completion.get() end, { desc = 'Trigger completion' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

