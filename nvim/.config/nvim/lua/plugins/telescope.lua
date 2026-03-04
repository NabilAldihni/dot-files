return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local telescope = require('telescope')
		local builtin = require('telescope.builtin')
		local actions = require('telescope.actions')
		
		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"^.git/",
					"node_modules/",
					".cache/",
					"%.git/",
				},
				mappings = {
					n = {
						["<C-d>"] = actions.preview_scrolling_down,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
					},
					i = {
						["<C-d>"] = actions.preview_scrolling_down,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-f>"] = actions.preview_scrolling_down,
						["<C-b>"] = actions.preview_scrolling_up,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = true,
				},
			},
		})
		
		vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
		vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Telescope grep word under cursor' })
		vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
	end
}
