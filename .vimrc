" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'chazy/dirsettings'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-dirvish'
Plug 'mhinz/vim-signify'
Plug 'rstacruz/vim-closer'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
Plug 'will133/vim-dirdiff'

" Initialize plugin system
call plug#end()

syntax on
color dracula

let g:lightline = { 'colorscheme': 'dracula', }

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

"------------------------------------------------------------
" Autocommands. augroup and autocmd! are necessary. See
" https://superuser.com/a/634037 for details.
augroup WjkohAutocommands
  autocmd!
augroup END

" Use patience diff. See https://github.com/chrisbra/vim-diff-enhanced.
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
