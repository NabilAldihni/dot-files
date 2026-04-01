return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        lazy = false,
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {},
                automatic_enable = false,
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client.supports_method('textDocument/completion') then
                        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
                    end
                end,
            })

            -- vim.lsp.config merges with lspconfig's bundled defaults (cmd, filetypes,
            -- root_dir patterns) — you only need to specify overrides here.
            -- An empty table is valid and just uses the defaults as-is.
            vim.lsp.config('ts_ls', {
                root_dir = function(bufnr)
                    local fname = vim.api.nvim_buf_get_name(bufnr)
                    vim.notify("ts_ls root_dir called, fname: " .. tostring(fname))
                    local found = vim.fs.find(
                        { 'tsconfig.json', 'tsconfig.base.json', 'package.json', 'pnpm-lock.yaml' },
                        { path = fname, upward = true }
                    )
                    vim.notify("ts_ls found: " .. vim.inspect(found))
                    local result = vim.fs.dirname(found[1])
                    vim.notify("ts_ls root_dir result: " .. tostring(result))
                    return result
                end,
            })
            vim.lsp.enable('ts_ls')

            vim.lsp.config('lua_ls', {})
            vim.lsp.config('pyright', {})
            vim.lsp.config('clangd', {})
            vim.lsp.config('eslint', {})
            vim.lsp.config('html', {})
            vim.lsp.config('cssls', {})
            vim.lsp.config('bashls', {})
            vim.lsp.config('cairo_ls', {})

            vim.lsp.enable('ts_ls')
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('clangd')
            vim.lsp.enable('eslint')
            vim.lsp.enable('html')
            vim.lsp.enable('cssls')
            vim.lsp.enable('bashls')
            vim.lsp.enable('cairo_ls')
        end,
    }
}

