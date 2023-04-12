local M = {}

function M.setup()
	local packer_bootstrap = false

	local conf = {
	}

	local function plugins(use)
		-- Package management stuff
		use 'wbthomason/packer.nvim'

		-- Random editing stuff
		use 'jiangmiao/auto-pairs'
		use 'Yggdroot/indentLine'
		use 'Vimjas/vim-python-pep8-indent'

		-- Colors
		use 'jeffkreeftmeijer/vim-dim'
		use 'chriskempson/base16-vim'
		use 'morhetz/gruvbox'
		use 'sainnhe/everforest'

		-- LSP Config
		use "williamboman/mason.nvim"
		use "williamboman/mason-lspconfig.nvim"

		use {
			"neovim/nvim-lspconfig",
			event = "BufReadPre",
			config = function()
				require("config.lsp").setup()
			end
		}

		use {
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup {}
			end,
		}

		use 'hrsh7th/cmp-nvim-lsp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/cmp-path'
		use 'hrsh7th/nvim-cmp'

		use 'L3MON4D3/LuaSnip'
		use 'saadparwaiz1/cmp_luasnip'
		use 'rafamadriz/friendly-snippets'

		-- Statusline
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'nvim-tree/nvim-web-devicons', opt = true }
		}
	end

	vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	local packer = require "packer"
	packer.init(conf)
	packer.startup(plugins)
end

return M
