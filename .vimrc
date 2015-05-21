"------------------------------------------------------------
" Pathogen.
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window for multiple buffers, and/or:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities.  As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>


"------------------------------------------------------------
" Customizations.
set textwidth=90
set infercase
set shiftround
set number
if exists('+relativenumber')
    set relativenumber
endif

set background=dark
set t_Co=16
colorscheme solarized

if exists('+macmeta')
    set macmeta
endif
if has('gui_running')
    set cursorline
    set guioptions-=T	" Remove toolbar
    set guifont=Droid\ Sans\ Mono:h11,Monaco:h12
endif
let mapleader=','
set scrolloff=2		" Keep some context
set sidescrolloff=5	" Keep some context
set incsearch
set history=1000
set viminfo^=!
set viminfo+=%3		" Save and restore the buffer list
set clipboard=unnamed
if has('unnamedplus')
    set clipboard=unnamedplus
endif
set noimdisable		" http://tech.groups.yahoo.com/group/vim-mac/message/12312
set path+=/opt/local/include,../include,../external
set tags=./tags;
set autoread
set autowrite
set backup
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/tmp/undo//
endif
set backupdir=~/.vim/tmp/backup//   " include full path
set spellfile=~/.vim/spell/en.utf-8.add
" What if &spellfile is a list of filenames?
silent execute 'mkspell! ' . &spellfile
set spelllang=en_us
set dictionary+=/usr/share/dict/words
set showmatch
set complete-=i
set completeopt=longest,menuone,preview
set colorcolumn=+1
set lazyredraw

set wildignore+=*/tmp/*,*.so,*.swp,*.o,*.obj,.DS_Store    " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.exe   " Windows
set wildmode=longest:full,full

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10
set fileformats+=mac

set noignorecase " ignorecase has a problem with tag jump Ctrl-]
map / /\c
map ? /\c

" From https://github.com/tpope/vim-sensible.
set list
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if exists('+breakindent')
  set breakindent  " https://retracile.net/wiki/VimBreakIndent
  set showbreak=\ +
endif

runtime macros/matchit.vim	" Enable matchit


"------------------------------------------------------------
" Mappings.
map <tab> %
nnoremap <Leader>. :e .<CR>
nnoremap <Leader>a :A<CR>
nnoremap D d$  " Make D behave.
nnoremap j gj
nnoremap k gk


"------------------------------------------------------------
" Undotree.
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 30
let g:undotree_WindowLayout = 2
nnoremap <Leader>u :UndotreeToggle<CR>


"------------------------------------------------------------
" Grep.
if executable('ag')
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" '\b' matches a word boundary. ! in grep! prevents a jump to the first occurence.
nnoremap <Leader>* :grep! "\b<C-R><C-W>\b" %<CR>:cwindow<CR>:redraw!<CR>
nnoremap <Leader>g* :grep! "\b<C-R><C-W>\b" *<CR>:cwindow<CR>:redraw!<CR>


"------------------------------------------------------------
" Autocommands.
autocmd BufEnter * silent! lcd %:p:h
autocmd VimResized * wincmd =  " Resize splits when the window is resized

autocmd BufEnter * if filereadable('SConstruct') || filereadable('SConscript') | silent! setlocal makeprg=scons\ -u | else | silent! setlocal makeprg= | endif
autocmd FileType text,plaintex,tex,gitcommit,hgcommit setlocal spell

autocmd BufNewFile,BufReadPost SConstruct,SConscript set filetype=python
autocmd BufNewFile,BufReadPost *.md set filetype=markdown  " Since Vim detects *.md as Modula-2 except for README.md.

if executable('marked')
  autocmd BufNewFile,BufRead *.md silent! execute '!marked ' . shellescape(expand('%'))
endif


" http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow


"------------------------------------------------------------
" NERDTree.
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1


"------------------------------------------------------------
" CtrlP.
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|nerdtree'

if executable('ag')
  let g:ctrlp_user_command = 'ag %s --ignore-case --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ -g ""'
  let g:ctrlp_clear_cache_on_exit = 1
else
  let g:ctrlp_user_command = {
        \ 'types': {
          \ 1: ['.git', 'cd %s && git ls-files'],
          \ 2: ['.hg', 'hg --cwd %s locate -I .'],
          \ },
        \ 'fallback': 'find %s -type f'
        \ }
endif


"------------------------------------------------------------
" Buffergator.
let g:buffergator_split_size = 10
let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = 'T'
nnoremap <Leader>b :BuffergatorOpen<CR>


"------------------------------------------------------------
" Tagbar.
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_left = 1
let g:tagbar_width = 30
nnoremap <Leader>t :TagbarOpenAutoClose<CR>


"------------------------------------------------------------
" YouCompleteMe.
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
nnoremap <Leader>j :YcmCompleter GoTo<CR>


"------------------------------------------------------------
" Ultisnips.
let g:UltiSnipsExpandTrigger="<c-j>"


"------------------------------------------------------------
" Airline.
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
