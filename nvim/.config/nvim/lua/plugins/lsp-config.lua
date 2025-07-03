return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "bashls", "pyright", "rust_analyzer" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.bashls.setup({})
            lspconfig.jedi_language_server.setup({})
            lspconfig.rust_analyzer.setup({
		diagnostic = {
			refreshSupport = false,
		}
	    })
        end
    }
}
