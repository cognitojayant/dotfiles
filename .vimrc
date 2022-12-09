set nocompatible
let mapleader="<Space>"

map <leader>ss :setlocal spell!<cr>
nmap <C-s> :w!<CR>
inoremap jj <Esc>
inoremap jk <Esc>



"=====================================================
"" Autocmd
"=====================================================
"au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"



"=====================================================
"" General settings
"=====================================================
set filetype=xml
filetype on
filetype plugin on
filetype plugin indent on
syntax enable
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set autoread
set hidden
" User Interface Options
set laststatus=2
set ruler
set wildmenu
set tabpagemax=40
set mouse=a
set t_Co=256
set number
set spell
set ruler
set ttyfast
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set cursorline
set showmatch
set enc=utf-8
set nobackup
set nowritebackup
set noswapfile
set scrolloff=10
set clipboard=unnamed
set exrc
set secure
set noerrorbells
set magic
set confirm  "display a confirmation dialog when closing an unsaved files
syntax on "enable syntax highlighting


call plug#begin('~/.vim/plugged')

    Plug 'scrooloose/nerdtree'                " Project and file navigation
    Plug 'majutsushi/tagbar'                  " Class/module browser
    Plug 'kien/ctrlp.vim'                     " Fast transitions on project files

    "-------------------=== Other ===-------------------------------
    Plug 'vim-airline/vim-airline'               " Lean & mean status/tabline for vim
    Plug 'vim-airline/vim-airline-themes'     " Themes for airline
    Plug 'powerline/powerline'               " Powerline fonts plugin
    Plug 'fisadev/FixedTaskList.vim'          " Pending tasks list
    Plug 'rosenfeld/conque-term'              " Consoles as buffers
    Plug 'tpope/vim-surround'               " Parentheses, brackets, quotes, XML tags, and more
    Plug 'flazz/vim-colorschemes'             " Colorschemes

    "-------------------=== Snippets support ===--------------------
    Plug 'honza/vim-snippets'                 " Snippets manager
    Plug 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
    Plug 'tomtom/tlib_vim'                    " dependencies #2
    Plug 'honza/vim-snippets'                 " snippets repo

    "-------------------=== Languages support ===-------------------
    Plug 'tpope/vim-commentary'               " Comment stuff out
    Plug 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
    Plug 'Rykka/riv.vim'                      " ReStructuredText plugin

    "-------------------=== Python  ===-----------------------------
    Plug 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
    Plug 'scrooloose/syntastic'               " Syntax checking plugin for Vim

call plug#end()


"=====================================================
"" Tabs / Buffers settings
"=====================================================
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q :SyntasticCheck # <CR> :bp <BAR> bd #<CR>

"" Search settings
"=====================================================
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=42
autocmd BufEnter *.py :call tagbar#autoopen(0)


"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=40
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap " :NERDTreeToggle<CR>


"=====================================================
"" Python settings
"=====================================================

" python executables for different plugins
let g:pymode_python='python3'
let g:syntastic_python_python_exec='python3'

" rope
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_auto_project=0
let g:pymode_rope_enable_autoimport=0
let g:pymode_rope_autoimport_generate=0
let g:pymode_rope_guess_project=0

" documentation
let g:pymode_doc=0
let g:pymode_doc_bind='K'

" lints
let g:pymode_lint=0

" virtualenv
let g:pymode_virtualenv=1

" breakpoints
let g:pymode_breakpoint=1
let g:pymode_breakpoint_key='<leader>b'

" syntax highlight
let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=1
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all

" highlight 'long' lines (>= 80 symbols) in python files
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
    autocmd FileType python,rst,c,cpp set nowrap
    autocmd FileType python,rst,c,cpp set colorcolumn=80
augroup END

" code folding
let g:pymode_folding=0

" pep8 indents
let g:pymode_indent=1

" code running
let g:pymode_run=1
let g:pymode_run_bind='<F5>'

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='X'
let g:syntastic_style_error_symbol='X'
let g:syntastic_warning_symbol='x'
let g:syntastic_style_warning_symbol='x'
let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python']

" YouCompleteMe
set completeopt-=preview

let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0

nmap <leader>g :YcmCompleter GoTo<CR>
nmap <leader>d :YcmCompleter GoToDefinition<CR>
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
