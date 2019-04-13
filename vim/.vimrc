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
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Initialize plugin system
call plug#end()

source /usr/share/vim/google/google.vim

color dracula
let g:lightline = { 'colorscheme': 'dracula', }

if has('termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Use patience diff. See https://github.com/chrisbra/vim-diff-enhanced.
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

let mapleader      = ' '
let maplocalleader = ' '

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader>F        :Files<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>

"------------------------------------------------------------
" Autocommands. augroup and autocmd! are necessary. See
" https://superuser.com/a/634037 for details.
augroup WjkohAutocommands
  autocmd!
  au User lsp_setup call lsp#register_server({
        \ 'name': 'Kythe Language Server',
        \ 'cmd': {server_info->['/google/bin/releases/grok/tools/kythe_languageserver', '--google3']},
        \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto'],
        \})

  au User lsp_setup call lsp#register_server({
      \ 'name': 'CiderLSP',
      \ 'cmd': {server_info->[
      \   '/google/bin/releases/editor-devtools/ciderlsp',
      \   '--tooltag=vim-lsp',
      \   '--noforward_sync_responses',
      \ ]},
      \ 'whitelist': ['c', 'cpp', 'proto', 'textproto', 'go'],
      \})
augroup END

set cursorline

nnoremap <Leader>] :LspDefinition<CR>
nnoremap <Leader>[ :LspReferences<CR>
nnoremap <Leader>i :LspHover<CR>


" Send async completion requests.
" WARNING: Might interfere with other completion plugins.
let g:lsp_async_completion = 1

set number
set relativenumber
