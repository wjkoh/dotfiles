" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'bronson/vim-visual-star-search'
Plug 'dense-analysis/ale'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'google/vim-maktaba'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper'  " See ~/.vim/after/plugin/grepper.vim.
Plug 'mhinz/vim-signify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'natebosch/vim-lsc'
Plug 'rhysd/clever-f.vim'
Plug 'tmsvg/pear-tree'
Plug 'tommcdo/vim-lion'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'  " See ~/.vim/after/plugin/abolish.vim.
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'  " '[f', ']f': switch between source and header files.
Plug 'wellle/targets.vim'


" Initialize plugin system
call plug#end()
" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()

set autowrite         " Write files when navigating with :next/:previous
set belloff=all       " Bells are annoying
set breakindent       " Wrap long lines *with* indentation
set breakindentopt=shift:2
set colorcolumn=81,82 " Highlight 81 and 82 columns
set completeopt+=popup
set completepopup=height:40,width:80,align:menu,border:off
set conceallevel=2
set cursorline
set dictionary=/usr/share/dict/words
set expandtab
set foldlevelstart=20
set foldmethod=indent " Simple and fast
set foldtext=""
set hlsearch
set ignorecase        " Search in case-insensitively
set infercase         " Smart casing when completing
set list
set mouse=a           " Mouse support in the terminal
set nohlsearch
set nojoinspaces      " No to double-spaces when joining lines
set noswapfile        " No backup files
set nowrapscan
set number
set pumheight=20
set relativenumber
set shiftwidth=2
set showbreak=↳       " Use this to wrap long lines
set showcmd
set smartcase         " Case-smart searching
set splitbelow        " Split below current window
set splitright        " Split window to the right
set tabstop=2
set ttymouse=xterm2
set undofile          " Maintain undo history between sessions.
set updatetime=150    " default updatetime 4000ms is not good for async update
set wildcharm=<Tab>   " Defines the trigger for 'wildmenu' in mappings

" Copy to/from system clipboard.
if has("unnamedplus")
  set clipboard=unnamed,unnamedplus
else
  set clipboard=unnamed
endif

let s:undodir=$HOME . '/.vim/undodir_' . $USER
if isdirectory(s:undodir) || mkdir(s:undodir, 'p', 0700)
  let &undodir=s:undodir
endif

color dracula
if has('termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has('nvim-0.3.2') || has('patch-8.1.0360')
  set diffopt+=algorithm:histogram,indent-heuristic
endif

"------------------------------------------------------------
" Autocommands. augroup and autocmd! are necessary. See
" https://superuser.com/a/634037 for details.
augroup WjkohAutocommands
  autocmd!
  autocmd InsertLeave * silent! set nopaste
  " Automatically equalize window splits.
  autocmd VimResized * wincmd =
  " Auto-read external file changes, compliments the vim-auto-save plugin.
  autocmd CursorHold * silent! checktime
  " Restore default Enter/Return behaviour for the command line window.
  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

augroup autoformat_settings
  autocmd!
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType proto,javascript,typescript AutoFormatBuffer clang-format
augroup END


let g:signify_vcs_cmds = {
      \ 'hg':       'hg diff --color=never --nodates -U0 -r .^ %f',
      \ }
let g:signify_vcs_cmds_diffmode = {
      \ 'hg':       'hg cat -r .^ %f',
      \ }

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'relativepath', 'modified'] ]
      \}
      \}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'c': ['clang-format'],
      \ 'cpp': ['clang-format'],
      \ 'java': ['google-java-format'],
      \ 'python': ['yapf'],
      \}

let g:lion_squeeze_spaces = 1
let g:clever_f_across_no_line    = 1
let g:clever_f_fix_key_direction = 1

let g:lsc_auto_map = {
      \ 'defaults': v:true,
      \  'Completion': 'omnifunc',
      \}

" Run fzf+files and fzf+ag on the current file's parent directory and its
" subdirectories, not the current working directory.
command! -bang FilesDot call fzf#vim#files(expand('%:p:h'), <bang>0)
command! -bang -nargs=* AgDot call fzf#vim#ag(<q-args>, \ {'dir': expand('%:p:h')}, <bang>0)

" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

let g:neosnippet#enable_complete_done = 1
let g:neosnippet#enable_completed_snippet = 1

let g:undotree_WindowLayout             = 4

" Mappings.
let mapleader      = ' '
let maplocalleader = ','

" Enter command mode via ';'
noremap ; :
" Make dot work on visual line selections.
xnoremap . :norm.<CR>
" Y should behave like D and C, from cursor till the end of line.
noremap Y y$
" U for redo, the opposite of u for undo.
nnoremap U <C-r>

"-----------------------------
" Navigation mappings
"-----------------------------
nnoremap <C-h> gT
" Use <Leader>1 instead to turn off highlighting.
nnoremap <C-l> gt

" Move vertically by visual line unless preceded by a count.
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

"-----------------------------
" Increment and decrement mappings
"-----------------------------
nnoremap + <C-a>
nnoremap - <C-x>
xnoremap + g<C-a>
xnoremap - g<C-x>

" Zoom the current file into a new tab.
nnoremap <C-w>z  :tab split<CR>

nnoremap <Leader>.       :FilesDot<CR>
nnoremap <Leader>1       :set hlsearch!<CR>
nnoremap <Leader>2       :w<CR>
nnoremap <Leader><Enter> :Buffers<CR>
nnoremap <Leader>a       :AgDot<CR>
nnoremap <Leader>f       :Files<CR>
nnoremap <Leader>h       :Helptags<CR>
nnoremap <Leader>l       :Lines<CR>
nnoremap <Leader>u       :UndotreeToggle<CR>

" Mapping selections for various modes.
nmap <Leader>! <Plug>(fzf-maps-n)
omap <Leader>! <Plug>(fzf-maps-o)
xmap <Leader>! <Plug>(fzf-maps-x)
imap <C-x>!   <Plug>(fzf-maps-i)

" Do not use `set pastetoggle=<Leader>p`. It can be triggered even in the
" insert mode, which means that your past text should not contain <Leader>p.
nnoremap <Leader>p :set paste!<CR>
nnoremap <Leader>c :cclose<CR>:lclose<CR>:helpclose<CR>:UndotreeHide<CR>

" Search for user-supplied term. Don't use `-dir file` because it uses the
" original path for symlink.
nnoremap <Leader>/ :execute 'Grepper -cd ' . expand('%:p:h')<CR>
nnoremap <LocalLeader>/ :Grepper -dir cwd<CR>

" Search for current word or selection. Don't use `-dir file` because it uses
" the original path for symlink.
nnoremap <Leader>* :execute 'Grepper -cword -noprompt -cd ' . expand('%:p:h')<CR>
nnoremap <LocalLeader>* :Grepper -cword -noprompt -dir cwd<CR>

" Fold the current indent.
nnoremap <Leader>z zazz

xmap gs <Plug>(GrepperOperator)

" Replace the current word or selection with a new text. Use `.` to repeat.
nnoremap <Leader>s :let @/='\<'.expand('<cword>').'\>'<CR>:set hlsearch<CR>cgn
xnoremap <Leader>s "sy:let @/=@s<CR>:set hlsearch<CR>cgn

" Edit and reload my .vimrc file.
command Change :tabe $MYVIMRC
command Update :source $MYVIMRC

" use :SignifyDiff instead.
" command HgDiff :!hg vimdiff % -r .^

if &diff
  syntax off
endif

"-----------------------------
" Center navigation mappings
"-----------------------------
noremap {  {zz
noremap }  }zz
noremap n  nzz
noremap N  Nzz
noremap ]s ]szz
noremap [s [szz

" Insert <CR> mapping that:
" - autocloses the popup menu and adds a newline
" - does pear-tree processing
" - does vim-endwise processing
imap <expr> <CR> (pumvisible() ? "\<C-e>\<Plug>DiscretionaryEnd" : "\<Plug>(PearTreeExpand)\<Plug>DiscretionaryEnd")

if filereadable(expand('~/.vimrc_google'))
  source ~/.vimrc_google
endif
