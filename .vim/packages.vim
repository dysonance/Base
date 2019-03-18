" Setup {{{

set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

let $PYTHON_VERSION='3.7'
let $PYTHON_BINARY=$HOME.'/Chest/apps/frameworks/Python.framework/Versions/'.$PYTHON_VERSION.'/bin/python3'

" }}}

" List {{{


" Editing Utilities {{{

Plug 'jiangmiao/auto-pairs'     " auto-insertion of brackets/quotes
Plug 'tpope/vim-surround'       " easily surround chunks of text with delimiters
Plug 'Valloric/YouCompleteMe'   " code completion functionality (see pre-requisites on GitHub)
Plug 'scrooloose/nerdcommenter' " comment adding utility
Plug 'junegunn/vim-easy-align'  " align blocks of code easily
Plug 'rhysd/vim-clang-format'   " clang format whole file
Plug 'tomtom/tskeleton_vim'     " filetype snippet skeletons
Plug 'tomtom/tlib_vim'          " utility functions for vim (req for tskeleton)

" }}}


" Workflow Utilities {{{

Plug 'embear/vim-localvimrc'       " enable use of vimrc files local to directory
Plug 'vim-airline/vim-airline'     " more informative vim status bar
Plug 'chrisbra/csv.vim'            " improved csv viewing/editing interface
Plug 'jreybert/vimagit'            " improved git repo workflow within vim
Plug 'airblade/vim-gitgutter'      " git diffs in the gutter
Plug 'tpope/vim-fugitive'          " git command line interface simplification
Plug 'jpalardy/vim-slime'          " allow connection to a REPL running in a slime/tmux session
Plug 'vim-syntastic/syntastic'     " Linter/syntax checker for Vim
Plug 'scrooloose/nerdtree'         " file explorer side bar
Plug 'Xuyuanp/nerdtree-git-plugin' " add git indications to nerd tree sidebar
Plug 'octref/RootIgnore'           " auto-add project gitignore files to vim wildignore
Plug 'AndrewRadev/linediff.vim'    " vimdiff groups of lines right next to each other
Plug 'ctrlpvim/ctrlp.vim'          " fuzzy search utility
Plug 'mhinz/vim-grepper'           " easily search for patterns in files
Plug 'rizzatti/dash.vim'           " mac dash documentation app integration
Plug 'python-mode/python-mode'     " python workflow utilities (linting, completion, formatting)
Plug 'davidhalter/jedi-vim'        " jedi python autocompletion/documentation library
Plug 'tweekmonster/braceless.vim'  " smarter navigation of code that doesnt use braces for scope
Plug 'tmhedberg/matchit'           " extent the % to match HTML, LaTeX, and other languages
Plug 'alvan/vim-closetag'          " make html editing less miserable

" }}}


" Language Support {{{

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " go language support
Plug 'vim-scripts/Vim-R-plugin'                    " R language support improved
Plug 'plasticboy/vim-markdown'                     " Markdown language support
Plug 'vim-pandoc/vim-pandoc'                       " required for Rmd support
Plug 'vim-pandoc/vim-pandoc-syntax'                " required for Rmd support
Plug 'vim-pandoc/vim-rmarkdown'                    " support for RMarkdown and KnitR
Plug 'vim-python/python-syntax'                    " enhanced python syntax highlighting

" }}}


call plug#end()

" }}}

" Optional {{{

runtime macros/matchit.vim  " extended `%` logical navigation

" }}}

" Configuration {{{

" Syntastic {{{

" General

"let g:syntastic_debug=3  " turn on to see diagnostics when checking
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors=1
let g:syntastic_enable_signs=1
let g:syntastic_filetype_map={"smarty": "html"}
let ignored_messages=
            \ [
            \ 'invalid preprocessing directive',
            \ 'should have comment.*or be unexported',
            \ 'receiver name should be a reflection of its identity',
            \ '[Ii][Dd].*should be.*ID',
            \ 'func name will be used as',
            \ 'ALL_CAPS in Go names',
            \ 'proprietary attribute "nonce"',
            \ 'discarding unexpected <meta>',
            \ "plain text isn't allowed",
            \ '<a> illegal characters found in URI',
            \ 'struct field Cpu should be CPU',
            \ 'comment on exported type',
            \ 'a blank import should be only in a main or test package',
            \ 'that stutters'
            \ ]
let g:syntastic_quiet_messages={"regex": ignored_messages}
autocmd filetype qf setlocal wrap

" C/C++
let g:syntastic_c_compiler='clang'
let g:syntastic_c_auto_refresh_includes=1

let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_checkers=['gcc'] " 'clang_check', 'clang_tidy', 'gcc']
let g:syntastic_cpp_clang_tidy_args=' -checks=*'
let g:syntastic_cpp_config_file='.syntastic_cpp_config'
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_auto_refresh_includes=1

" Python
let g:syntastic_python_checkers=['python3', 'pyflakes'] ", 'pylint']

" Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" }}}

" YouCompleteMe {{{

let g:ycm_complete_in_strings=0                 " dont autocomplete strings
let g:ycm_collect_identifiers_from_tags_files=1 " use the tags file from ctags command
let g:ycm_python_binary_path=$PYTHON_BINARY     " use python 3 instead of system python
let g:ycm_max_num_candidates=20                 " maximum number of completion options to use (default 50)
let g:ycm_min_num_identifier_candidate_chars=2  " min chars id candidate must have to appear
let g:ycm_confirm_extra_conf=0                  " dont ask to reload conf every time
set completeopt=menu,menuone                    " turn off the preview/documentation window
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_show_diagnostics_ui=0
let g:ycm_error_symbol='E'
let g:ycm_warning_symbol='W'
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" }}}

" Snippets {{{

" UltiSnip {{{

let g:UltiSnipsExpandTrigger="<C-G>"
let g:UltiSnipsJumpForwardTrigger="<C-W>"
let g:UltiSnipsJumpBackwardTrigger="<C-B>"

" }}}

" tSkeleton {{{

autocmd BufNewFile *.md TSkeletonSetup template.md
autocmd BufNewFile *.lzz TSkeletonSetup template.lzz

" }}}

" }}}

" Braceless {{{

autocmd FileType python BracelessEnable +indent

" autocmd FileType julia BracelessEnable +indent

" }}}

" Python Syntax {{{

let g:black_linelength=120
let g:python_highlight_builtins=1
let g:python_highlight_exceptions=1
let g:python_highlight_string_formatting=1
let g:python_highlight_string_format=1
let g:python_highlight_string_templates=1
let g:python_highlight_indent_errors=1
let g:python_highlight_space_errors=1
let g:python_highlight_class_vars=1
let g:python_highlight_operators=1
let g:python_highlight_all=1

" }}}

" Python Mode {{{

let g:pymode_options_max_line_length=120
let g:pymode_python='python3'
let g:pymode_lint=0
let g:pymode_options_colorcolumn=0
let g:pymode_rope=0
let g:pymode_run=0
let g:pymode_breakpoint=0

" }}}

" Vim Jedi (Python) {{{

" NOTE: jedi and pymode can conflict so you may need to decide between them
"let g:jedi#completions_enabled=0

let g:jedi#popup_select_first=0    " dont auto-select first autocompletion
let g:jedi#show_call_signatures="" " dont show call signatures (distracting)
let g:jedi#use_tabs_not_buffers=1
let g:jedi#use_splits_not_buffers="winwidth"

" shortcuts/keymaps
let g:jedi#documentation_command="K"
let g:jedi#goto_definitions_command=""
let g:jedi#rename_command=""

" }}}

" NeoVim Configurations {{{

let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/local/bin/python3'

" }}}

" Local Vim RC {{{

let g:localvimrc_sandbox=0
let g:localvimrc_ask=0

" }}}

" Airline {{{

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'

" }}}

" Auto-Pairs {{{

" " NOTE: including angle brackets will mess with greater than / less than
" let g:AutoPairs={'(' : ')', '[' : ']', '{' : '}',"'" : "'",'"' : '"', '`' : '`', '<' : '>'}
" let g:AutoPairsMoveCharacter="()[]{}<>\"'"

" }}}

" Git Gutter {{{

let g:gitgutter_realtime=0 " dont update gutter in realtime to stop lag (will update on save)
set updatetime=100         " redo gutter git diff every 100 ms (1/10 sec)

highlight GitGutterAdd ctermfg=DarkGreen ctermbg=NONE
highlight GitGutterDelete ctermfg=DarkRed ctermbg=NONE
highlight GitGutterChange ctermfg=Yellow ctermbg=NONE
highlight GitGutterChangeDelete ctermfg=DarkYellow ctermbg=NONE

" }}}

" C++ Enhanced Highlighting {{{

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
"let g:cpp_class_decl_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_experimental_template_highlight = 1
"let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 0

" }}}

" {{{ Slime Settings

let g:slime_target="tmux"      " screen is the default
let g:slime_preserve_curpose=0 " dont preserve current cursor position when sending text
let g:slime_python_ipython=1   " allow pasting more than one line at a time in ipython

" }}}

" Clang Format {{{

let g:clang_format#detect_file_style=1

" }}}

" Nerd Tree {{{

"let loaded_netrwPlugin=1
let NERDTreeRespectWildIgnore=1

" }}}

" Nerd Commenter {{{

let g:NERDSpaceDelims = 1            " add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1        " use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'      " align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1      " allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " enable trimming of trailing whitespace when uncommenting
let g:NERDCustomDelimiters = {
            \ 'c': { 'left': '/**','right': '*/' },
            \ 'python': { 'left': '#', 'leftAlt': '', 'rightAlt': '' }
            \ }

" }}}

" {{{CtrlP

" show files in hidden/invisible folders
let g:ctrlp_show_hidden=1

" ignore git ignored files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" }}}

" Pandoc {{{

let g:pandoc#command#autoexec_command="pandoc pdf"
let g:pandoc#command#latex_engine="xelatex"
let g:pandoc#command#autoexec_on_writes=0
let g:pandoc#command#prefer_pdf=1
let g:pandoc#syntax#conceal#use=0  " turn off pretty syntax (slow)

" }}}

" Grepper {{{

" let g:grepper.tools=['git', 'grep']
" let g:grepper.stop=100
" let g:grepper.highlight=1
let g:grepper = {
            \ 'tools':['git', 'grep'],
            \ 'stop': 100,
            \ 'highlight': 1,
            \ }

" }}}

" Close Tag {{{

let g:closetag_filenames='*.html,*.tpl' " filetypes that activate the plugin
let g:closetag_shortcut='>'             " shortcut for closing tags
let g:closetag_close_shortcut=''        " add > at current position w/o closing current tag

" }}}

" Matchit {{{

autocmd FileType smarty let b:match_words='<div:</div>,<script:</script>,<table:</table>,<:>,<tag>:</tag>'
autocmd FileType html   let b:match_words='<div:</div>,<script:</script>,<table:</table>,<:>,<tag>:</tag>'

" }}}

" }}}

" Make vim use triple bracket fold markers in vimrc
" vim:foldmethod=marker:foldlevel=0
