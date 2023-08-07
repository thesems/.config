return {
    "nvim-treesitter",
    config = function()
        require('lualine').setup({
            ensure_installed = { "go", "python", },
            indent = { enable = true },
        })
    end
}
