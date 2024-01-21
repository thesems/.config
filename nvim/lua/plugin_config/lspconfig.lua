-- return {
--     { "neovim/nvim-lspconfig",
--         dependencies = {
--         "williamboman/mason.nvim",
--         "williamboman/mason-lspconfig.nvim"
--         },
--         config = function()
--             local lsp = require('lsp-zero')
--             lsp.on_attach(function(client, bufnr)
--                 -- lsp.default_keymaps({buffer = bufnr}) -- use only if you want lsp-zero keybindings
--                 local opts = {buffer = bufnr, noremap = true, silent = true}
--                 vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--                 vim.keymap.set("n", "<leader>e", function() vim.lsp.buf.hover() end, opts)
--                 vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--                 vim.keymap.set("n", "<leader>E", function() vim.diagnostic.open_float() end, opts)
--                 vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--                 vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--                 vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
--                 vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.references() end, opts)
--                 vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
--                 vim.keymap.set("n", "<leader>ff", function() vim.lsp.buf.format() end, opts)
--                 vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--             end)
--             local capabilities = vim.lsp.protocol.make_client_capabilities()
--             capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
--             require('mason').setup({})
--             require('mason-lspconfig').setup({
--                 ensure_installed = { "rust_analyzer", "gopls", "pyright", "svelte" },
--                 automatic_installation = true,
--                 handlers = { lsp.default_setup, },
--             })
--             require("lspconfig").pyright.setup {
--                capabilities = capabilities,
--             }
--             require("lspconfig").svelte.setup{}
--             require("lspconfig").gopls.setup{}
--             require("lspconfig").tailwindcss.setup({})
--         end
--     },
-- }

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "tsserver", "rust_analyzer", "gopls", "svelte" }
})

local lspconfig = require('lspconfig')

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

require("lspconfig").tsserver.setup({})
require("lspconfig").gopls.setup({})
require("lspconfig").tailwindcss.setup({})
require("lspconfig").pyright.setup { capabilities = capabilities }
require("lspconfig").svelte.setup{}

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
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})