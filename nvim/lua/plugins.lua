require("lazy").setup({
    { "ellisonleao/gruvbox.nvim", name = "gruvbox", priority = 1000 },
    "tpope/vim-commentary",
    "tpope/vim-surround",
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        keys = {
            { "<space>t", "<cmd>Neotree toggle<cr>", desc = "NeoTree" }
        },
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
        }
    },
    "stevearc/oil.nvim",
    "nvim-lualine/lualine.nvim",
    {'akinsho/toggleterm.nvim', version = "*", opts = {
        open_mapping = [[<c-\>]], direction = 'float' }
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "jose-elias-alvarez/null-ls.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.ruff,
            null_ls.builtins.diagnostics.ruff,
          }
        })
      end
    },
})
