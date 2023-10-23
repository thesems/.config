local plugins = {
    -- Language Support
    -- Added this plugin.
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
    -- {'rebelot/kanagawa.nvim'},
    {'ellisonleao/gruvbox.nvim'},
    {'nvim-lualine/lualine.nvim'},
    {'akinsho/toggleterm.nvim', version = "*", opts = {
        open_mapping = [[<c-\>]], direction = 'float'
    }},
    {'numToStr/Comment.nvim'},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
}
return plugins
