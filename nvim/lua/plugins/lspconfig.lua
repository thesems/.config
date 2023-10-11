return {
    { "neovim/nvim-lspconfig",
        dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
        },
        config = function()
            local lsp = require('lsp-zero')
            lsp.on_attach(function(client, bufnr)
                -- lsp.default_keymaps({buffer = bufnr}) -- use only if you want lsp-zero keybindings
                local opts = {buffer = bufnr, noremap = true, silent = true}
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "<leader>e", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>E", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("n", "<leader>ff", function() vim.lsp.buf.format() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { "pyright" , "rust_analyzer", "gopls" },
                automatic_installation = true,
                handlers = { lsp.default_setup, },
            })
            require("lspconfig").pyright.setup {
                capabilities = capabilities,
            }
        end
    },
}
