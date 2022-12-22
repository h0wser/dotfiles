local M = {}

function M.setup()
	local packer_bootstrap = false

	local conf = {
	}

	local function plugins(use)
		use 'wbthomason/packer.nvim'
		use 'jiangmiao/auto-pairs'
		use 'Yggdroot/indentLine'
		use 'leafOfTree/vim-svelte-plugin'
		use 'maxmellon/vim-jsx-pretty'
		use 'Vimjas/vim-python-pep8-indent'
		use 'jeffkreeftmeijer/vim-dim'
		use 'chriskempson/base16-vim'
		use 'morhetz/gruvbox'

		use {
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufReadPre",
			wants = { "nvim-lsp-installer" },
			config = function() 
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/nvim-lsp-installer"
			},
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
	end

	vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	local packer = require "packer"
	packer.init(conf)
	packer.startup(plugins)
end

return M
