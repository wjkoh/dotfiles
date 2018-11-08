" Launch Vimwiki (<Leader>ww) to see My Vim Tips.
set nocompatible              " be iMproved, required
filetype off                  " required

" http://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim
" If this makes a delay when you type space in insert mode, check :imap <leader>
" and remove all of them. A.vim is a common culprit.
nnoremap <Space> <Nop>
let mapleader = "\<Space>"  " Use double quotes here to enable escaping.
let maplocalleader = ","

" Specify a directory for plugins.
" - Avoid using standard Vim directory names like 'plugin'.
call plug#begin('~/.vim/plugged')

" Am I at work?
if filereadable(expand('~/.at_google'))
  " Google-only
  source ~/.vimrc_google
else
  " Non-Google only
  " Add maktaba and codefmt to the runtimepath.
  " (The latter must be installed before it can be used.)
  Plug 'google/vim-maktaba'
  Plug 'google/vim-codefmt'

  " Also add Glaive, which is used to configure codefmt's maktaba flags. See
  " `:help :Glaive` for usage.
  Plug 'google/vim-glaive'
endif

Plug 'airblade/vim-rooter'  " For BAddFiles().
Plug 'chazy/dirsettings'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'chriskempson/base16-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'rstacruz/vim-closer'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'vimwiki/vimwiki'
Plug 'will133/vim-dirdiff'

" Initialize plugin system
call plug#end()
filetype plugin indent on

" It seems like the glaive#Install() should go after the "call plug#end()" and
" "filetype plugin indent on". See https://github.com/google/vim-glaive for
" details.
call glaive#Install()

" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
if filereadable(expand('~/.at_google'))
else
  " TODO(wjkoh): Check if MacOS or not as well.
  " MacOS X with MacPorts only.
  Glaive codefmt clang_format_executable=/opt/local/libexec/llvm-3.8/bin/clang-format
endif

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
set noswapfile

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window for multiple buffers, and/or:
" set confirm
" set autowriteall

" Already in vim-sensible.
" Better command-line completion
" set wildmenu

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

" Already in vim-sensible.
" Allow backspacing over autoindent, line breaks and start of insert action
" set backspace=indent,eol,start

" Already in vim-sensible.
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
" set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Already in vim-sensible.
" Display the cursor position on the last line of the screen or in the status
" line of a window
" set ruler

" Already in vim-sensible.
" Always display the status line, even if only one window is displayed
" set laststatus=2

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

" Already in vim-sensible.
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>


"------------------------------------------------------------
" Customizations.

" Already in vim-sensible.
" set scrolloff=2		" Keep some context
" set sidescrolloff=5	" Keep some context
" set incsearch
" set history=1000
" set viminfo^=!
" set autoread
" From https://github.com/tpope/vim-sensible.
" set list
" if &listchars ==# 'eol:$'
"   set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" endif
" runtime macros/matchit.vim	" Enable matchit
" set tags=./tags;
" set complete-=i

set textwidth=80
set infercase
set shiftround
set number
if exists('+relativenumber')
  set relativenumber
endif

set background=dark
let base16colorspace=256
colorscheme base16-eighties
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

if exists('+macmeta')
  set macmeta
endif
if has('gui_running')
  set cursorline
  " Remove toolbar
  set guioptions-=T
  if has('unix')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  elseif has('macunix')
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11,Monaco:h12
  endif
endif
" Save and restore the buffer list
"set viminfo+=%3
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamedplus
endif
" http://tech.groups.yahoo.com/group/vim-mac/message/12312
set noimdisable
" This works with vim-rooter and adds all the subdirectories in the project directory.
set path+=**
set autowrite
set backup
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/tmp/undo//
endif
" include full path
set backupdir=~/.vim/tmp/backup//

" What if &spellfile is a list of filenames?
" zg to add word to word list
" zw to reverse
" zug to remove word from word list
" z= to get list of possibilities
set spellfile=~/.vim/spell/en.utf-8.add
silent execute 'mkspell! ' . &spellfile
set spelllang=en_us
set spell

highlight clear SpellBad
highlight clear SpellCap
highlight clear SpellRare
highlight clear SpellLocal
highlight SpellBad cterm=bold

set dictionary+=/usr/share/dict/words
set showmatch
set completeopt=longest,menuone,preview
set colorcolumn=+1
set lazyredraw

set wildignore+=*.so,*.swp,*.o,*.obj,.DS_Store,*.jpg,*.png,*.exe
" Get lower priority in wildmenu.
set suffixes+=.sty,.bst,.cls
set wildignorecase
set wildmode=list:longest,full

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

" ignorecase has a problem with tag jump Ctrl-]
set noignorecase
map / /\c
map ? /\c

if exists('+breakindent')
  " https://retracile.net/wiki/VimBreakIndent
  set breakindent
  set showbreak=\ +
endif

"------------------------------------------------------------
" Mappings.
" Make D behave.
nnoremap D d$
nnoremap j gj
nnoremap k gk

"------------------------------------------------------------
" Undotree.
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SplitWidth = 30
let g:undotree_WindowLayout = 2

"------------------------------------------------------------
" Grep.
if executable('ag')
  " --vimgrep option is nice but not availabe in ag prior to 0.25. For example,
  " 0.19.2 in Goobuntu doesn't have it.
  "set grepprg=ag\ --vimgrep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  " let g:ackprg = 'ag --vimgrep'
endif

"------------------------------------------------------------
" Autocommands.
autocmd VimResized * wincmd =  " Resize splits when the window is resized
autocmd FileType text,plaintex,tex,gitcommit,hgcommit setlocal spell

autocmd BufNewFile,BufReadPost *.cu set filetype=cuda
autocmd BufNewFile,BufReadPost *.cuh set filetype=cuda

" Format BUILD file on save.
autocmd FileType bzl AutoFormatBuffer buildifier

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
" Airline.
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_theme='base16'

let g:airline#extensions#tabline#enabled = 1
" Display filename only.
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline#extensions#tabline#fnamecollapse = 1

"------------------------------------------------------------
" Dirvish.
autocmd FileType dirvish sort r /[^\/]$/  " Sort directory at the top.

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

" Rooter.
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', 'WORKSPACE']

" Sneak.
let g:sneak#label = 1
let g:sneak#streak = 1

nnoremap <Leader>b :b <C-d>
nnoremap <Leader>c :cclose<CR>
nnoremap <Leader>e :e **/
nnoremap <Leader>g :grep<Space>
nnoremap <Leader>* :Grepper -tool ag -cword -noprompt<CR>
nnoremap <Leader>j :tjump /
nnoremap <Leader>q :q<CR>
" <Leader>w conflicts with <Leader>ww and <Leader>ws.
nnoremap <Leader>s :w<CR>
nnoremap <Leader>u :UndotreeToggle<CR>
" `set pastetoggle` doesn't work when the leader key is <Space>.
nnoremap <Leader>z :set invpaste<CR>

nnoremap <Leader><Down> :resize +2<CR>
nnoremap <Leader><Left> :vertical resize +2<CR>
nnoremap <Leader><Right> :vertical resize -2<CR>
nnoremap <Leader><Up> :resize -2<CR>

if filereadable(expand('~/.at_google'))
  nnoremap <Leader>m :Blaze <C-d>
else
  nnoremap <Leader>m :make<CR>
endif

function! IsTextFile(fname)
  if executable("file")
    return system("file -ib " . a:fname) =~# "^text/"
  endif
  return true
endfunction

" This function requires vim-rooter.
function! BAddFiles()
    " Run Rooter first.
    :Rooter

    " Git.
    let file_list = []
    let git_cmd = "git"
    if executable(git_cmd)
      let git_args = "ls-files --full-name --modified --exclude-standard 2>/dev/null"
      let file_list += systemlist(git_cmd . " " . git_args)
    endif

    " Mercurial.
    let hg_cmd = "hg"
    if executable(hg_cmd)
      let hg_args = "status --no-status --added --modified 2>/dev/null"
      let file_list += systemlist(hg_cmd . " " . hg_args)
    endif

    " Add all the files to the buffer list.
    for file in file_list
      let fname = getcwd() . "/" . file
      if filereadable(fname) && IsTextFile(fname)
        execute "badd " . file
      endif
    endfor

    " Piper.
    if exists(":PiperLoadActiveAsBuffers") == 2
      :silent PiperLoadActiveAsBuffers
    endif
endfunction

autocmd BufReadPost * call BAddFiles()

" vim-signify.
let g:signify_vcs_list = [ 'git', 'hg', 'svn', 'perforce' ]
" See go/citcdiff.
let g:signify_vcs_cmds = {'perforce':'DIFF=%d" -U0" citcdiff %f || [[ $? == 1 ]]'}

" vim-diff-enhanced.
let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'

" Syntastic.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" Vimwiki.
let wiki_1 = {}
let wiki_1.path = '~/vimwiki-personal/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.index = 'Home'

let wiki_2 = {}
let wiki_2.path = '~/vimwiki-work/'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'
let wiki_2.index = 'Home'

let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
