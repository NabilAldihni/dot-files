
return {
	"nvim-treesitter/nvim-treesitter",
    branch = "master",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {"lua", "python", "bash", "javascript","dart","solidity","c","powershell","markdown","markdown_inline"},
			highlight = { enable = true },
			indent = { enable = true }
		})
	end
}

