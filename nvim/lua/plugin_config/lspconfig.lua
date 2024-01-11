require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "tsserver", "rust_analyzer", "gopls", "svelte" }
})

local lspconfig = require('lspconfig')
local util = lspconfig.util
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require("lspconfig").lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath "config" .. "/lua"] = true,
                },
            },
        },
    }
}

require("lspconfig").rust_analyzer.setup {
    filetypes = {"rust"},
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
            fullFunctionSignatures = {
                enable = true,
            },
        },
    },
}
require("lspconfig").tsserver.setup({})
require("lspconfig").gopls.setup({})
require("lspconfig").tailwindcss.setup({})
require("lspconfig").pyright.setup {}
require("lspconfig").svelte.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>e', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--                 vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--                 vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rf', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>ff', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set("n", "<leader>E", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end,
})
