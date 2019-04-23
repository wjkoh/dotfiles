" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'chazy/dirsettings'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'fisadev/vim-isort'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'google/vim-maktaba'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-dirvish'
Plug 'leafgarland/typescript-vim'
Plug 'mhinz/vim-signify'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'rstacruz/vim-closer'
Plug 'ryanolsonx/vim-lsp-javascript'
Plug 'ryanolsonx/vim-lsp-python'
Plug 'ryanolsonx/vim-lsp-typescript'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'  " '[f', ']f': switch between source and header files.
Plug 'vimwiki/vimwiki'
Plug 'will133/vim-dirdiff'

" Initialize plugin system
call plug#end()
" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()

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

nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader>F        :Files<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>

"------------------------------------------------------------
" Autocommands. augroup and autocmd! are necessary. See
" https://superuser.com/a/634037 for details.
augroup WjkohAutocommands
  autocmd!
  if executable('/usr/local/opt/llvm/bin/clangd')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['/usr/local/opt/llvm/bin/clangd', '-background-index']},
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
          \ })
  elseif executable('clangd')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'clangd',
          \ 'cmd': {server_info->['clangd', '-background-index']},
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
          \ })
  endif
  " https://gist.github.com/romainl/ce55ce6fdc1659c5fbc0f4224fd6ad29
  autocmd FileType c,cpp setlocal makeprg=/usr/local/opt/llvm/bin/clang-tidy
  autocmd FileType javascript setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
  autocmd FileType javascript setlocal makeprg=eslint\ --format\ compact
  autocmd FileType python setlocal makeprg=pylint\ --output-format=parseable
  autocmd BufWritePost *.py,*.js silent make! <afile> | silent redraw!
  autocmd QuickFixCmdPost [^l]* cwindow
augroup END

set completeopt+=preview
set cursorline
set expandtab
set number
set relativenumber
set shiftwidth=2
set tabstop=2
set undofile  " Maintain undo history between sessions.
if mkdir(expand('~/.vim/undofiles'), 'p', 0700)
  set undodir=~/.vim/undofiles
endif
set hlsearch

nnoremap <Leader>] :LspDefinition<CR>
nnoremap <Leader>[ :LspReferences<CR>
nnoremap <Leader>i :LspHover<CR>

augroup autoformat_settings
  autocmd!
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
augroup END

" Send async completion requests.
" WARNING: Might interfere with other completion plugins.
let g:lsp_async_completion = 1
" enable echo under cursor when in normal mode
let g:lsp_diagnostics_echo_cursor = 1

if filereadable(expand('~/.vimrc_google'))
  source ~/.vimrc_google
endif
