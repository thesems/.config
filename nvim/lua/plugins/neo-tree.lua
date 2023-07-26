return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    keys = {
        { "<space><space>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = {
        filesystem = {
            follow_current_file = true,
            hijack_newrw_behavior = "open_current",
        }
    }
}
