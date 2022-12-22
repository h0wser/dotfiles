local M = {}

local servers = {
	ccls = { cmd = {"/home/h0wser/projects/build-docker-test/ccls_docker.sh"}},
	cmake = {},
	pyright = {},
	sumneko_lua = {},
	jsonls = {}
}

local function on_attach(client, bufnr)
	-- use LSP as handler for formatexpr
	vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	require("config.lsp.keymaps").setup(client, bufnr)
end

local opts = {
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
}

function M.setup()
	local lspconfig = require('lspconfig')
	local lsp_defaults = lspconfig.util.default_config

	lsp_defaults.capabilities = vim.tbl_deep_extend(
		'force',
		lsp_defaults.capabilities,
		require('cmp_nvim_lsp').default_capabilities()
	)

	require("config.lsp.installer").setup(servers, opts)
end

return M
