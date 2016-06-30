"------------------------------------------------------------
" Pathogen.
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" http://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim
" If this makes a dealy when you type space in insert mode, check :imap <leader>
" and remove all of them. A.vim is a common culprit.
nnoremap <Space> <Nop>
let mapleader = "\<Space>"  " Use double quotes here to enable escaping.

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" At work, or not:
if filereadable(expand('~/.at_google'))
  " Google-only
  source ~/.vimrc_local
else
  " Non-Google only
  Plugin 'Valloric/YouCompleteMe'

  " Add maktaba and codefmt to the runtimepath.
  " (The latter must be installed before it can be used.)
  Plugin 'google/vim-maktaba'
  Plugin 'google/vim-codefmt'
  " Also add Glaive, which is used to configure codefmt's maktaba flags. See
  " `:help :Glaive` for usage.
  Plugin 'google/vim-glaive'

  "------------------------------------------------------------
  " YouCompleteMe.
  let g:ycm_confirm_extra_conf = 0
  let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
endif

Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'mhinz/vim-signify'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()

" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]


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
set pastetoggle=<Leader>z


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
let base16colorspace=256
colorscheme base16-eighties

if exists('+macmeta')
  set macmeta
endif
if has('gui_running')
  set cursorline
  set guioptions-=T	" Remove toolbar
  set guifont=Droid\ Sans\ Mono:h11,Monaco:h12
endif
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
nnoremap D d$  " Make D behave.
nnoremap j gj
nnoremap k gk
nnoremap <Leader>s :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>h :tabprev<CR>
nnoremap <Leader>l :tabnext<CR>


"------------------------------------------------------------
" Undotree.
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 30
let g:undotree_WindowLayout = 2
nnoremap <Leader>u :UndotreeToggle<CR>


"------------------------------------------------------------
" Grep.
if executable('ag')
  " --vimgrep option is nice but not availabe in ag prior to 0.25. For example,
  " 0.19.2 in Goobuntu doesn't have it.
  "set grepprg=ag\ --vimgrep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m
endif

" '\b' matches a word boundary. ! in grep! prevents a jump to the first
" occurence.
nnoremap <Leader>* :grep! "\b<C-R><C-W>\b"<CR>:cwindow<CR>


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
let g:ctrlp_match_window = 'top'
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore .git5_specs
      \ --ignore review
      \ -g ""'


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
nnoremap <Leader>t :TagbarToggle<CR>


"------------------------------------------------------------
" YouCompleteMe.
nnoremap <Leader>] :YcmCompleter GoTo<CR>
nnoremap <Leader>g] :tab split <Bar> YcmCompleter GoTo<CR>


"------------------------------------------------------------
" Ultisnips.
let g:UltiSnipsExpandTrigger="<c-j>"


"------------------------------------------------------------
" Airline.
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_theme='base16'


" Tmuxline.
" Run :Tmuxline airline and :TmuxlineSnapshot! ~/dotfiles/.tmuxline.conf in Vim.
let g:tmuxline_preset = {
      \'a'       : '#(whoami)@#(hostname -s)#{online_status}#{prefix_highlight}',
      \'b disabled'       : '',
      \'c disabled'       : '',
      \'win'     : ['#I', '#W'],
      \'cwin'    : ['#I', '#W'],
      \'x'       : ['#{battery_icon}#{battery_percentage}', '#{cpu_icon}#{cpu_percentage}'],
      \'y'       : ['%l:%M%p', '%a', '%Y-%m-%d'],
      \'z'       : '#S:#I',
      \'options' : {'status-justify': 'left'}}
