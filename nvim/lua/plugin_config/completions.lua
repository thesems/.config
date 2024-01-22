local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-o>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = "path", group_index = 2 },
        { name = 'luasnip', group_index = 2 },
    }, {
        { name = 'buffer' },
    }),
    -- formatting = {
    --     format = lspkind.cmp_format({
    --         mode = "symbol",
    --         max_width = 50,
    --         symbol_map = { Copilot = "" }
    --     })
    -- }
})
