require'nvim-treesitter.configs'.setup {
    filesystem = {
        filtered_items = {
            visible = true,
        },
        follow_current_file = true,
        hijack_newrw_behavior = "open_current",
    }
}
