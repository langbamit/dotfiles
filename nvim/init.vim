" ===================== Plugins =====================
call plug#begin(expand('~/.config/nvim/plugged'))
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    Plug 'itchyny/lightline.vim'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}


    Plug 'jiangmiao/auto-pairs'

    Plug 'liuchengxu/vista.vim'

    Plug 'drewtempelmeyer/palenight.vim'
    Plug 'airblade/vim-rooter'

    Plug 'sheerun/vim-polyglot'
    Plug 'cespare/vim-toml'
    Plug 'stephpy/vim-yaml'
    Plug 'rust-lang/rust.vim'
    Plug 'othree/html5.vim'
    Plug 'godlygeek/tabular' " Required by vim-markdown
    Plug 'plasticboy/vim-markdown'
call plug#end()

" ===================== General Settings =====================
let mapleader=','
filetype plugin indent on
syntax on

set encoding=utf-8
set backspace=indent,eol,start
set noshowmode
set hidden
set number
set modeline
set modelines=10
set cmdheight=2
set scrolloff=2
set updatetime=300
set relativenumber
set background=dark
set laststatus=2
set pumheight=15
set splitright
set splitbelow
set mouse=a

set signcolumn=yes


set smartcase
set ignorecase

set breakindent
set smartindent
set nofoldenable
set colorcolumn=80
set foldmethod=syntax

"Turn off swap files
set noswapfile
set nobackup
set nowritebackup

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

colorscheme palenight

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" ===================== [Auto] Cmd =====================
" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e
autocmd FocusGained,BufEnter * :checktime
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


augroup coccmd
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" ===================== Keyboard shortcuts =====================

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"Jump to start and end of line using the home row keys
map H ^
map L $

" Move by line (include wrap line)
nnoremap j gj
nnoremap k gk

" Quick save
nnoremap <C-s> :w<CR>

nnoremap <leader>w <C-^>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/
" ===================== Custom Mappings =====================


" Comment map
nmap <Leader>c gcc
" Line comment command
xmap <Leader>c gc


cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-p> :FZF -m<CR>

nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Confirm completion
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" ===================== Functions =====================

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" ===================== Variables =====================

let g:lightline = {
        \ 'colorscheme': 'palenight',
        \ }

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'


" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}%{NearestMethodOrFunction()}


