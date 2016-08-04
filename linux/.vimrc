set nocompatible

set runtimepath+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'

filetype off " Required.

call vundle#begin(path)
Plugin 'VundleVim/Vundle.vim'     " Let Vundle manage Vundle, required
Plugin 'Valloric/YouCompleteMe'   " A fast, as-you-type, fuzzy-search code completion engine for Vim
Plugin 'bling/vim-airline'        " Lean & mean status/tabline for vimthat's light as air
Plugin 'raimondi/delimitmate'     " Provides insert mode auto-completion for quotes, parens, brackets, etc.
Plugin 'OmniSharp/omnisharp-vim'  " Plugin for Vim to provide IDE like abilities for C#
Plugin 'scrooloose/syntastic'     " Syntax checking plugin that runs files through external syntax checkers and displays any resulting errors
Plugin 'scrooloose/nerdtree'      " Allows you to explore your filesystem and to open files and directories
Plugin 'pangloss/vim-javascript'  " Vastly improved Javascript indentation and syntax support
Plugin 'tpope/vim-surround'       " Provides mappings to easily delete, change and add such surroundings in pairs
Plugin 'mattn/emmet-vim'
"Plugin 'Shougo/unite.vim'         " Can search and display information from arbitrary sources like files, buffers, recently used files or registers
"Plugin 'tpope/vim-dispatch'       " Asynchronous build and test dispatcher. (I don't know what this does)
call vundle#end()

filetype indent plugin on " Required.

colorscheme molokai

" Section: Options
" ----------------

syntax on               " Enable syntax highlighting
set t_vb=               " Disables visual bell entirely
set ruler               " Show line + col number of the cursor pos separated by comma if there's room, the rel pos of the displayed text in file is shown on far right
set hidden              " When off a buffer is unloaded when it is abandoned when on a buffer becomes hidden when it is abandoned
set number              " Display line numbers
set ttyfast             " Indicates fast terminal connection More chars will be sent to screen for redrawing instead of using ins/del line cmds
set mouse=a             " Enable the use of the mouse.  Only works for certain terminals (xterm, MS-DOS, Win32... etc.)
set showcmd             " Show (partial) command in the last line of the screen set this option off if your terminal is slow in visual made shows selected area
set confirm             " Instead of failing a command because of unsaved changes
set wildmenu            " When 'wildmenu' is on, command-line completion operates in an enhanced mode
set hlsearch            " Highlights words as you search
set smarttab            " Shiftwidth at the start of the line, softtabstop everywhere else
set expandtab           " Turns tabs into spaces
set showmatch           " When a bracket is inserted, briefly jump to the matching one the jump is only done if the match can be seen on the screen
set incsearch           " While typing a search show where the pattern as it was typed so far matches The matched string is highlighted
set smartcase           " Case insensitive searches become sensitive with capitals
set ignorecase          " The case of normal letters is ignored
set autoindent          " Copy indent from current line when starting a new line
set smartindent         " Do smart autoindenting when starting a new line
set complete-=i         " Searching includes can be slow ~tpope
set cmdheight=2         " Number of screen lines to use for the command-line.  Helps avoiding hit-enter prompts
set laststatus=2        " Always display the status line, even if only one window is displayed *Airline!
set shiftwidth=2        " Indentation settings for using 2 spaces instead of tabs.
set softtabstop=2       " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
set nostartofline       " Stop certain movements from always going to the 1st character of a line, affected gg and G
set ttimeoutlen=50      " Make Esc work faster, the time in milliseconds that is waited for a key code or mapped key sequence to complete
set encoding=utf-8      " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file
"set notimeout ttimeout " Quickly time out on keycodes not on mappings (Not sure if I want this) 
"set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1

set backspace=indent,eol,start  " Makes backspace work

" Undo with as many levels as you like stored into file to keep undos across sessions
set undodir=C:\Users\Shahan\vimfiles\undodir
set undofile

" Section: Mappings
" -----------------

"  nnoremap and nmap are not exactly the same
"  if you do nmap a <esc>
"  after that, `nmap s a` and `nnoremap s a` will do different things
"  the first will map s to <esc> and the second will map s to the original function of a (insert left of cursor)

" The default leader key: '\', mine is set to the Space Bar
let mapleader = "\<Space>"
nnoremap <Leader><Leader> gg=G
nnoremap <Leader>/ :nohl<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>s :so %<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>sp :setlocal spell! spelllang=en_us<CR>
nnoremap <Leader>ws :set list!<CR>

" Automatically jump to end of text you pasted: I can paste multiple lines multiple times with simple ppppp.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Maps gg and G to fix nostartofline 
nnoremap gg gg0
nnoremap G G$
xnoremap gg gg0
xnoremap G G$

inoremap jk <Esc>
nnoremap <C-i> :vs<CR>
nnoremap ff zz 

" Shift lines up or down
noremap <C-j> ddp
noremap <C-k> ddkkp

" For when syntax highlighting/colorscheme dies because a file is too long.
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Search Google for text highlighted in visual mode.
if has("win32")
  "Windows options here
  vmap <Leader>s y<Esc>:silent exec
        \ ":!start c:/Program Files (x86)/Google/Chrome/Application/chrome.exe http://www.google.com/search?q=\""
        \ . substitute(@0,"\\W\\+\\\\|\\<\\w\\>"," ","g")
        \ . "\""<CR><CR>
else
  if has("unix")
    function! GoogleSearch()
      let searchterm = getreg("g")
      silent! exec "silent! !firefox \"http://google.com/search?q=" . searchterm . "\" &"
    endfunction
    vnoremap <Leader>s "gy<Esc>:call GoogleSearch()<CR>
    "Windows options here
  endif
endif
"\ . substitute(@0,"","","g")

" Section: Autocommands
" ---------------------

" Always restore last cursor position
if has("autocmd")
  augroup restoreCursor
    autocmd!
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line ("'\"") <= line("$") |
          \   exe "normal! g'\"" |
          \ endif
  augroup END
endif

" Skeletons
"autocmd BufNewFile *.c 0r ~/.vim/skeleton.c | call cursor(6,0)
"autocmd BufNewFile *.py 0r ~/.vim/skeleton.py| call cursor(2,0)

" Section: Plugin Settings
" ------------------------

" Airline

let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

" YouCompleteMe

let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
"let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_confirm_extra_conf = 0
set completeopt-=preview
"let g:EclimCompletionMethod = 'omnifunc'
"let g:ycm_auto_trigger = 0

let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_server_python_interpreter = 'python'

" Jump to declaration or definition MOVE THIS
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" Syntastic

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_auto_jump = 0
let g:syntastic_check_on_wq = 1 
let g:syntastic_javascript_checkers = ['jsl']
let b:syntastic_skip_checks = 0

" Omnisharp

set omnifunc=syntaxcomplete#Complete

augroup omnisharp_commands
  autocmd!

  "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
  "autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

  " Synchronous build (blocks Vim)
  "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
  " Builds can also run asynchronously with vim-dispatch installed
  " autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
  " automatic syntax check on events (TextChanged requires Vim 7.4)
  " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

  " Automatically add new cs files to the nearest project on save
  autocmd BufWritePost *.cs call OmniSharp#AddToProject()

  "show type information automatically when the cursor stops moving
  autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

  "The following commands are contextual, based on the current cursor position.

  autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
  autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
  autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
  autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
  "finds members in the current buffer
  autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
  " cursor can be anywhere on the line containing an issue
  autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
  autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
  autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
  autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
  "navigate up by method/property/field
  autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
  "navigate down by method/property/field
  autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END
