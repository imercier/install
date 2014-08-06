set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
 
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
 
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
 
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
 
set showcmd         " Show (partial) command in status line.


set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
 
set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
 
set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.
 
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
 
set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.
 
set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
 
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.
 
set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.
 
set mouse=a         " Enable the use of the mouse.
 
filetype plugin indent on
syntax on
autocmd BufRead *.pde set filetype=c

"trailing whitespace:
match ErrorMsg '\s\+$'
match ErrorMsg '/\s\+$\| \+\ze\t/'
nnoremap rtw :%s/\s\+$//e<CR>


"restore vim at the same line last time opened
autocmd BufReadPost * silent! normal! g`"zv

"find this f*cking cursor
nnoremap x :set cursorline! cursorcolumn!<CR>

set noswapfile

"display name file
set laststatus=2

"hilight current line
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

function! GoogleSearch()
    let searchterm = getreg("g")
    silent! exec "silent! !iceweasel \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <F6> "gy<Esc>:call GoogleSearch()<CR>

"absolute path displayed
set statusline+=%F

"search results appear in the middle of the screen
set so=10

"Write the old file out when switching between files.
set autowrite

" Hide the mouse cursor while typing
set mousehide 

" Puts new vsplit windows to the right of the current
set splitright

" Puts new split windows to the bottom of the current
set splitbelow

let g:snips_author = 'Ivan Mercier <ivan.mercier@nexvision.fr>'
