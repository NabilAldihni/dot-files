return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require("flutter-tools").setup {
            lsp = {
                on_attach = function(client, bufnr)
                    local buf = vim.lsp.buf
                    local map = vim.api.nvim_buf_set_keymap
                    local opts = { noremap = true, silent = true }

                    map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                    map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                    map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                    map(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                end,
            },
            widget_guides = {
                enabled = true,
            },
            dev_log = {
                enabled = true,
                auto_open = false,
                open_cmd = "tabedit",
            },
            closing_tags = {
                highlight = "Comment",
                prefix = "// ",
                enabled = true,
            },
        }

        -- Global flutter command keymaps
        vim.keymap.set("n", "<leader>fr", "<cmd>FlutterRun<CR>", { desc = "Flutter Run" })
        vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<CR>", { desc = "Flutter Quit" })
        vim.keymap.set("n", "<leader>fd", "<cmd>FlutterDevices<CR>", { desc = "Flutter Devices" })
        vim.keymap.set("n", "<leader>fl", "<cmd>FlutterLogToggle<CR>", { desc = "Flutter Logs" })
    end,
}
