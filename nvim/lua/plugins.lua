require("lazy").setup({
    { "ellisonleao/gruvbox.nvim", name = "gruvbox", priority = 1000 },
    "tpope/vim-commentary",
    "tpope/vim-surround",
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/oil.nvim",
    -- "zbirenbaum/copilot.lua",
    "nvim-lualine/lualine.nvim",
    "simrat39/rust-tools.nvim",
    -- completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "github/copilot.vim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {'akinsho/toggleterm.nvim', version = "*", opts = {
        open_mapping = [[<c-\>]], direction = 'float' }
    },
    {
        "nvim-telescope/telescope.nvim", tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
})
