require('plugins').setup()
require('config.keymaps')

-- load snippets & completion
require('luasnip.loaders.from_vscode').lazy_load()
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = { behaviour = cmp.SelectBehavior.Select}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	sources = {
		{name = 'path'},
		{name = 'nvim_lsp', keyword_length = 3},
		{name = 'buffer', keyword_length = 3},
		{name = 'luasnip', keyword_length = 2},
	},
	window = {
		documentation = cmp.config.window.bordered()
	},
	formatting = {
		fields = {'menu', 'abbr', 'kind'},
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<Tab>'] = cmp.mapping(function(fallback)
			local col = vim.fn.col('.') - 1
			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
				fallback()
			else
				fallback()
				--cmp.complete()
			end
		end, {'i', 's'}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),
	}
})

vim.opt.signcolumn = "yes"

vim.diagnostic.config({signs=false, virtual_text=false})

vim.cmd([[
" ==== Colors ====

set background=dark
set t_Co=256
set termguicolors
let g:gruvbox_italic = 1
colorscheme gruvbox

" ==== indentLine ====
let g:indentLine_fileTypeExclude = ['json']

imap ö {
imap ä }
imap Ö [
imap Ä ]

nnoremap J 5j
nnoremap K 5k

nnoremap <A-q> vipgq

let mapleader = " "
let maplocalleader = ","

set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=0

set scrolloff=10

autocmd FileType javascript,javascriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2  expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType markdown setlocal ts=4 sts=4 expandtab
autocmd FileType python setlocal fo=cqj
autocmd FileType haskell setlocal ts=4 sts=4 expandtab
autocmd BufNewFile,BufRead *.md,*.mkdn,*.markdown,*.md.erb :set filetype=markdown

hi Pmenu ctermbg=8 ctermfg=11

]])
