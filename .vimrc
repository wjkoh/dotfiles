" Pathogen
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
set shiftwidth=4
set softtabstop=4
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

" Customization
set infercase
set shiftround
set nonumber
set relativenumber
set gdefault
set background=dark
colorscheme solarized
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set macmeta
    endif
endif
if has("gui_running")
    set cursorline
endif
set guioptions-=T	" Remove toolbar
set guifont=Droid\ Sans\ Mono:h11,Monaco:h12
let mapleader=","
set scrolloff=2		" Keep some context
set sidescrolloff=5	" Keep some context
set incsearch
"set nowrapscan		" Do not wrap around
set history=1000
set viminfo^=!
set viminfo+=%3		" Save and restore the buffer list
set clipboard=unnamed
if has('unnamedplus')
    set clipboard=unnamedplus
endif
set noimdisable		" http://tech.groups.yahoo.com/group/vim-mac/message/12312
set path+=/usr/local/include,/opt/local/include,./include;,./lib;
set tags+=./tags;,~/.vim/libstdc++_tags
set autoread
set autowrite
set backup
set undofile
set noswapfile
set backupdir=~/.vim/tmp/backup//   " include full path
set undodir=~/.vim/tmp/undo//

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

" https://github.com/tpope/vim-sensible
set list
set showbreak=↪
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  endif
endif

runtime macros/matchit.vim	" Enable matchit


" Mapping
nnoremap j gj
nnoremap k gk
map <tab> %
nnoremap <silent> <Leader>. :e .<CR>
nnoremap D d$   " Made D behave

nnoremap <Leader>a :Ack!<space>
nnoremap <Leader>gu :GundoToggle<CR>

" Grep or Ack
let s:grep_or_ack = 'Grep'
if executable('ack')
    let s:grep_or_ack = 'Ack'
endif
execute 'nmap <silent> <Leader>* :' . s:grep_or_ack . ' <cword> %<CR>'
execute 'nmap <silent> <Leader>g* :' . s:grep_or_ack . ' <cword><CR>'


" Autocommand
autocmd BufEnter * silent! lcd %:p:h
autocmd BufEnter *.tex silent! setlocal textwidth=75 spell spelllang=en_us
autocmd BufReadPre,BufNewFile SConstruct,Sconscript set filetype=python
autocmd BufEnter * if filereadable('SConstruct') || filereadable('SConscript') | silent! setlocal makeprg=scons\ -u | else | silent! setlocal makeprg= | endif
autocmd VimResized * :wincmd =  " Resize splits when the window is resized
"autocmd BufWritePost,FileWritePost * call UpdateTags()

function UpdateTags()
    if !filereadable('tags')
        return
    endif

    let l:ctags_options = "--sort=foldcase --c++-kinds=+p --fields=+iaS --extra=+q"
    let l:ctags_excludes = '--exclude="*/typeof/*" --exclude="*/preprocessed/*"'

    silent! execute "!(cd ". expand("%:p:h") .";ctags ". l:ctags_options ." *)&"

    let l:tags_list = findfile("tags", ".;", -1)
    if len(l:tags_list) > 1
        let l:tmpfile = tempname()
        let l:globaltags_path = fnamemodify(l:tags_list[-1], ":p:h")

        if l:globaltags_path == $HOME
            if len(l:tags_list) > 2
                let l:globaltags_path = fnamemodify(l:tags_list[-2], ":p:h")
            else
                return
            endif
        endif

        silent! execute "!(cd ". l:globaltags_path .";ctags ". l:ctags_options ." ". l:ctags_excludes ." -f ". l:tmpfile ." --file-scope=no -R; mv ". l:tmpfile ." tags)&"
    endif
endfunction

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


" NERDTree
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1


" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.o,*.obj,.DS_Store    " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.exe   " Windows
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|nerdtree'
let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
            \ 'fallback': 'find %s -type f'
            \ }


" Tagbar
autocmd VimEnter * nested :call tagbar#autoopen(1)
autocmd FileType * nested :call tagbar#autoopen(0)
autocmd BufEnter * nested :call tagbar#autoopen(0)


" NeoComplCache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1


" OmniCppComplete
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteScope = 1
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0 | pclose | endif


" Python-mode
let g:pymode_breakpoint_key = '<leader>pb'
let g:pymode_rope = 0
let g:pymode_rope_guess_project = 0
let g:pymode_lint_cwindow = 1
let g:pymode_folding = 0


" Powerline for Vim
let g:Powerline_symbols = 'unicode'
