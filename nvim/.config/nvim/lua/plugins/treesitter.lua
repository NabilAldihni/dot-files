
return {
	"nvim-treesitter/nvim-treesitter",
    branch = "master",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {"lua", "python", "bash", "javascript","dart"},
			highlight = { enable = true },
			indent = { enable = true }
		})
	end
}

