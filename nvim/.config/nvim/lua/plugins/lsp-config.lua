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
                automatic_enable = true
            })
            vim.lsp.config('solidity_ls', {})
            vim.lsp.enable('solidity_ls')
        end,
    }
}
