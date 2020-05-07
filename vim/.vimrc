" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-abolish'  " See ~/.vim/after/plugin/abolish.vim.
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'  " [f, ]f: switch between source and header files. [<Space>: insert blank lines.

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Yggdroot/indentLine'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'machakann/vim-highlightedyank'
Plug 'markonm/traces.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'natebosch/vim-lsc'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'unblevable/quick-scope'
Plug 'vim-python/python-syntax'

" Initialize plugin system
call plug#end()

" Note that vim-sensible already enabled many useful options, such as autoread.
set autowrite         " Write files when navigating with :next/:previous
set breakindent       " Wrap long lines *with* indentation
set breakindentopt=shift:2
set colorcolumn=81,82 " Highlight 81 and 82 columns
set cursorline
set dictionary=/usr/share/dict/words
set expandtab
set hlsearch
set ignorecase        " Search in case-insensitively
set infercase         " Smart casing when completing
set lazyredraw
set list
set makeprg=          " Set makeprg explicitly. Will be called at BufWritePost.
set mouse=a           " Mouse support in the terminal
set nohlsearch
set nojoinspaces      " No to double-spaces when joining lines
set noswapfile        " No backup files
set nottyfast
set nowrapscan
set number
set path+=**
set relativenumber
set shiftwidth=2
set showbreak=↳       " Use this to wrap long lines
set showcmd
set showmatch
set smartcase         " Case-smart searching
set spell spelllang=en_us
set splitbelow        " Split below current window
set splitright        " Split window to the right
set tabstop=2
set ttymouse=xterm2
set undofile          " Maintain undo history between sessions.
set updatetime=1000   " default updatetime 4000ms is not good for async update

" Copy to/from system clipboard.
set clipboard=unnamed
if has("unnamedplus")
  set clipboard=unnamed,unnamedplus
endif

let s:undodir=$HOME . '/.vim/undodir_' . $USER
if isdirectory(s:undodir) || mkdir(s:undodir, 'p', 0700)
  let &undodir=s:undodir
endif

augroup WjkohColorSchemeCustomizations
  " Clear the autocommands of the current group.
  autocmd!
  autocmd ColorScheme * highlight clear SpellBad | highlight SpellBad cterm=underline,italic
  autocmd ColorScheme * highlight clear SpellCap | highlight SpellCap cterm=underline,italic
  autocmd ColorScheme * highlight clear SpellLocal | highlight SpellLocal cterm=underline,italic
  autocmd ColorScheme * highlight clear SpellRare | highlight SpellRare cterm=underline,italic
augroup END

" :color <...> must run after WjkohColorSchemeCustomizations.
color dracula
if has('termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  " Mosh + tmux causes a color problem. See
  " https://github.com/mobile-shell/mosh/issues/928#issuecomment-427284270.
  " set termguicolors
endif

if has('patch-8.1.0360')
  set diffopt+=algorithm:patience,indent-heuristic
endif

"------------------------------------------------------------
" Autocommands.
augroup WjkohAutocommands
  " Clear the autocommands of the current group.
  autocmd!
  " Automatically equalize window splits.
  autocmd VimResized * wincmd =
  " Auto-read external file changes, compliments the vim-auto-save plugin.
  autocmd CursorHold * silent! checktime
  " See ~/.vim/plugin/osc52.vim.
  autocmd TextYankPost * if v:event.operator ==# 'y' | call SendViaOSC52(getreg('"')) | endif
  autocmd BufWritePost * if !empty(&makeprg) | exe 'Make' | endif
  " % to the next > and g% to the last <.
  autocmd FileType cpp setlocal matchpairs+=<:>
  autocmd FileType c,cpp setlocal commentstring=//\ %s
augroup END

augroup autoformat_settings
  " Clear the autocommands of the current group.
  autocmd!
  " TODO(wjkoh): Add clang-tidy and pylint.
  autocmd FileType cpp,python,proto,typescript,html,bzl compiler clang_format
  autocmd FileType python compiler yapf
augroup END

" Run fzf+files and fzf+ag on the current file's parent directory and its
" subdirectories, not the current working directory.
command! -bang FilesDot call fzf#vim#files(expand('%:p:h'), <bang>0)
command! -bang Args call fzf#run(fzf#wrap('args', {'source': argv()}, <bang>0))

" NOTE(wjkoh): Do not move this to ~/.vim/after/plugin.
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Mappings.
let mapleader      = ' '
let maplocalleader = ','

" Y should behave like D and C, from cursor till the end of line.
noremap Y y$

" gj gk g^ g$, etc. act on displayed lines rather than real lines.
" countG == :countG
" g* is like * that finds any substring
" W B E gE move by WORDS (whitespace)
" gp gP paste after/before but put cursor after.
" Emphasize hello: ysiw<em> <em>Hello</em> world!
" in visual mode, type o and O.
" :vert sf tensor_map.h

nnoremap <Leader>.        :FilesDot<CR>
nnoremap <Leader>1        :set hlsearch!<CR>
nnoremap <Leader><Enter>  :Buffers<CR>
nnoremap <Leader><Leader> `.
nnoremap <Leader>a        :Args<CR>
nnoremap <Leader>d        :SignifyHunkDiff<CR>
nnoremap <Leader>f        :Files<CR>
nnoremap <Leader>h        :Helptags<CR>
nnoremap <Leader>l        :Lines<CR>
nnoremap <Leader>m        :Marks<CR>
nnoremap <Leader>u        :UndotreeToggle<CR>

" vim-unimpaired required. Enter insert mode with 'paste' set. Leaving insert
" mode sets 'nopaste' automatically.
nmap <Leader>p ]op

" Easy search and replace. 3<leader>s -> replace the following 3 lines.
" https://vi.stackexchange.com/a/11450
nnoremap <expr> <leader>s (v:count == 0 ? ':%' : ':') . 's/<C-r><C-w>//g<Left><Left>'
nnoremap <expr> <leader>S (v:count == 0 ? ':%' : ':') . 's/<C-r><C-a>//g<Left><Left>'
" :help v:count -> <C-u> removes the line range that you get when typing ':' after a count.
" :help N: for the ':.,.+(count - 1)' expression.
vnoremap <expr> <leader>s 'y' . (v:count == 0 ? ':%' : ':.,.+' . (v:count - 1)) . 's/<C-R>"//g<Left><Left>'

" Edit and reload my .vimrc file.
command! Change tabe $MYVIMRC
command! Update source $MYVIMRC

" To begin diffing on all visible windows:
" :windo diffthis
" which executes :diffthis on each window.
" To end diff mode:
" :diffoff!
" (The ! makes diffoff apply to all windows of the current tab - it'd be nice if diffthis had the same feature, but it doesn't.)

" I prefer ag to ripgrep because I can do `:grep Trajectories **/*.cc`.
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
else
  echoerr 'ag not found.'
endif

command! -nargs=+ GrepArgs execute 'vimgrep /\C<args>/ ##' | cwindow

if filereadable(expand('~/.vimrc_google'))
  source ~/.vimrc_google
endif
