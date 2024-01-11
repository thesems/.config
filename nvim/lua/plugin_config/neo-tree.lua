require("neo-tree").setup {
    filesystem = {
        filtered_items = {
            visible = true,
        },
        follow_current_file = {
            enabled = true,
        },
        hijack_newrw_behavior = "open_current",
    }
}
