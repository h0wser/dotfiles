local utils = require("utils")
local M = {}

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
		require("config.lsp.keymaps").setup(client, args.buf)
	end
})
local function on_attach(client, bufnr)
	-- use LSP as handler for formatexpr
	vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	utils.log("RANG UTILS THING")
	require("config.lsp.keymaps").setup(client, bufnr)
end

local opts = {
	flags = {
		debounce_text_changes = 150,
	},
}

function M.setup()
	require("mason").setup()
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup({
		ensure_installed = {
			"clangd", "cmake", "pyright", "lua_ls", "jsonls"
		}
	})

	local lspconfig = require('lspconfig')
	local lsp_defaults = lspconfig.util.default_config
	lsp_defaults.capabilities = vim.tbl_deep_extend(
		'force',
		lsp_defaults.capabilities,
		require('cmp_nvim_lsp').default_capabilities()
	)

	lspconfig.clangd.setup({})
	lspconfig.cmake.setup({})
	lspconfig.pyright.setup({})
	lspconfig.lua_ls.setup({})
	lspconfig.jsonls.setup({})
end

return M
