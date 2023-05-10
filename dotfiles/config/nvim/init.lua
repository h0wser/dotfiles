require('plugins').setup()
require('config.keymaps')
require('config.lualine').setup()

-- load snippets & completion

require('luasnip.loaders.from_vscode').lazy_load()
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = { behaviour = cmp.SelectBehavior.Select}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
		documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered()
	},
	formatting = {
		fields = {'menu', 'abbr', 'kind'},
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({select = false}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
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

set t_Co=256
set termguicolors
let g:gruvbox_italic = 1
set background=dark

let g:everforest_background = 'soft'
let g:everforest_enable_italic = 1
colorscheme everforest

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
