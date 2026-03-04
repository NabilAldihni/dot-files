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
                ensure_installed = { 'lua_ls', 'pyright', 'ts_ls' },
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
                    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
                    
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client and client.supports_method('textDocument/completion') then
                        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
                    end
                end,
            })
            
            vim.lsp.config('solidity_ls', {})
            vim.lsp.enable('solidity_ls')
            vim.lsp.config('clangd', {})
            vim.lsp.enable('clangd')
        end,
    }
}
