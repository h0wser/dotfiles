local M = {}

function M.setup()
	require('lualine').setup {
		options = {
			icons_enabled = true,
			component_separators = { left = '', right = ''},
			section_separators = { left = '', right = ''},
			ignore_focus = {},
			theme = 'everforest'
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = { {'filename', path=1}},
			lualine_x = {'encoding', 'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {'location'},
			lualine_y = {},
			lualine_z = {}
		},
	}
end

return M
