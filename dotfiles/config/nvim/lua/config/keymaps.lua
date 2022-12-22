-- Global keymaps that are used everywhere


function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", option, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', '<S-Tab>', '<C-D>')


