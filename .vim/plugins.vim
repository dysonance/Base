" Setup {{{

let $PYTHON_VERSION='3.8'
let $PYTHON_BINARY=$HOME."/Applications/Frameworks/Python.framework/Versions/".$PYTHON_VERSION."/bin/python3"

set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

" }}}

" List {{{

" Editing Utilities {{{

Plug 'jiangmiao/auto-pairs'       " auto-insertion of brackets/quotes
Plug 'tpope/vim-surround'         " easily surround chunks of text with delimiters
Plug 'scrooloose/nerdcommenter'   " comment adding utility
Plug 'junegunn/vim-easy-align'    " align blocks of code easily
Plug 'chrisbra/unicode.vim'       " utilities for working with unicode characters
Plug 'dhruvasagar/vim-table-mode' " table editing workflow enhancements

" }}}

" Workflow Utilities {{{

Plug 'jpalardy/vim-slime'             " allow connection to a REPL running in a slime/tmux session
Plug 'scrooloose/nerdtree'            " file explorer side bar
Plug 'airblade/vim-gitgutter'         " git diffs in the gutter
Plug 'Xuyuanp/nerdtree-git-plugin'    " add git indications to nerd tree sidebar
Plug 'vim-airline/vim-airline'        " more informative vim status bar
Plug 'vim-airline/vim-airline-themes' " options for theming airline
Plug 'jreybert/vimagit'               " improved git repo workflow within vim
Plug 'tpope/vim-fugitive'             " git command line interface simplification
Plug 'octref/RootIgnore'              " auto-add project gitignore files to vim wildignore
Plug 'AndrewRadev/linediff.vim'       " vimdiff groups of lines right next to each other
Plug 'ctrlpvim/ctrlp.vim'             " fuzzy search utility
Plug 'mhinz/vim-grepper'              " easily search for patterns in files
Plug 'rizzatti/dash.vim'              " mac dash documentation app integration
Plug 'tweekmonster/braceless.vim'     " smarter navigation of code that doesnt use braces for scope
Plug 'tmhedberg/matchit'              " extent the % to match HTML, LaTeX, and other languages
Plug 'alvan/vim-closetag'             " make html editing less miserable

" }}}

" Language Support {{{

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }                       " go language support
Plug 'vim-scripts/Vim-R-plugin'                                          " R language support improved
Plug 'plasticboy/vim-markdown'                                           " Markdown language support
Plug 'hashivim/vim-terraform'                                            " basic vim/terraform integration
Plug 'pearofducks/ansible-vim'                                           " common ansible filetypes (j2, hosts, certain yaml)
Plug 'mattn/emmet-vim'                                                   " web design workflow utilities
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' } " python workflow utilities (linting, completion, formatting)
Plug 'davidhalter/jedi-vim'                                              " jedi python autocompletion/documentation library

" Linting/Completion {{{

"Plug 'Valloric/YouCompleteMe'     " code completion functionality (see pre-requisites on GitHub)
Plug 'vim-syntastic/syntastic'        " Linter/syntax checker for Vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }}}

" }}}

call plug#end()

let b:ale_fixers = {'python': ['pyflakes', 'pylint'],}
let g:ale_python_pylint_options = '--jobs=$CPU --disable=all --enable=classes,imports,variables,typecheck,refactoring --disable=missing-docstring,invalid-name,redefined-builtin,invalid-slice-index,too-many-nested-blocks'

" }}}

" Optional {{{

runtime macros/matchit.vim  " extended `%` logical navigation

" }}}

" Configuration {{{

" Syntastic {{{

" General
autocmd BufRead,BufNewFile,BufLeave tmp.* silent! SyntasticToggleMode " dont syntax check tmp files
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
            \ 'that stutters',
            \ 'error strings should not be capitalized or end with punctuation'
            \ ]
let ignored_messages_html=
            \ [
            \ 'illegal characters found in URI',
            \ 'discarding unexpected plain text',
            \ 'content occurs after end of body',
            \ 'trimming empty <i>',
            \ 'trimming empty <span>',
            \ 'missing <li>',
            \ '<a> attribute with missing trailing quote mark',
            \ '<a> unexpected or duplicate quote mark',
            \ '<a> attribute with missing trailing quote mark',
            \ '<a> escaping malformed URI reference',
            \ 'invalid value "{{',
            \ 'attribute "',
            \ 'attribute name "$',
            \ 'attribute with missing trailing quote mark'
            \ ]
let g:syntastic_html_tidy_ignore_errors=ignored_messages_html
let g:syntastic_quiet_messages={"regex": ignored_messages}
autocmd filetype qf setlocal wrap

" C/C++
let g:syntastic_c_compiler='gcc'
let g:syntastic_c_config_file='.syntastic_c_config'
let g:syntastic_c_auto_refresh_includes=1
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_checkers=['gcc'] " 'clang_check', 'clang_tidy', 'gcc']
let g:syntastic_cpp_clang_tidy_args=' -checks=*'
let g:syntastic_cpp_config_file='.syntastic_cpp_config'
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_auto_refresh_includes=1

" Python
let g:syntastic_python_checkers=['python3', 'pyflakes', 'pylint']
let g:syntastic_python_pylint_post_args="--jobs=$CPU --disable=all --enable=classes,imports,variables,typecheck,refactoring --disable=missing-docstring,invalid-name,redefined-builtin,invalid-slice-index,too-many-nested-blocks"

" Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_echo_command_info = 0
let g:go_info_mode = 'gopls'
let g:go_def_mode = 'gopls'
let g:go_null_module_warning = 0
let g:syntastic_go_checkers = ['go', 'golint', 'govet']

" }}}

" YouCompleteMe {{{

let g:ycm_complete_in_strings=0                 " dont autocomplete strings
let g:ycm_collect_identifiers_from_tags_files=1 " use the tags file from ctags command
let g:ycm_python_binary_path=$PYTHON_BINARY     " use python 3 instead of system python
let g:ycm_max_num_candidates=20                 " maximum number of completion options to use (default 50)
let g:ycm_min_num_identifier_candidate_chars=2  " min chars id candidate must have to appear
let g:ycm_confirm_extra_conf=0                  " dont ask to reload conf every time
"set completeopt=menu,menuone                    " turn off the preview/documentation window
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_show_diagnostics_ui=0
let g:ycm_error_symbol='E'
let g:ycm_warning_symbol='W'
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" }}}

" Easy Align {{{

let g:easy_align_ignore_groups = ['Comment']

" }}}

" Snippets {{{

" UltiSnip {{{

let g:UltiSnipsExpandTrigger="<C-G>"
let g:UltiSnipsJumpForwardTrigger="<C-W>"
let g:UltiSnipsJumpBackwardTrigger="<C-B>"

" }}}

" }}}

" Braceless {{{

autocmd FileType python BracelessEnable +indent

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

" Local Vim RC {{{

let g:localvimrc_sandbox=0
let g:localvimrc_ask=0

" }}}

" Airline {{{

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#coc#enabled=1
let g:airline_theme='simple' " see here for options: https://github.com/vim-airline/vim-airline/wiki/Screenshots

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
let g:NERDCommentEmptyLines = 0      " allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " enable trimming of trailing whitespace when uncommenting
let g:NERDCustomDelimiters = {
            \ 'c': { 'left': '/**','right': '*/' },
            \ 'python': { 'left': '#', 'leftAlt': '', 'rightAlt': '' },
            \ 'julia': {'left': '#', 'leftAlt': '', 'rightAlt': ''},
            \ 'shell': {'left': '#', 'leftAlt': '', 'rightAlt': ''}
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
let g:pandoc#syntax#conceal#use=0         " turn off pretty syntax (slow)
let g:pandoc#modules#disabled=["folding"] " turn off folding (slow)

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

autocmd FileType smarty let b:match_words='<div:</div>,<script:</script>,<table:</table>,<form:</form>,<thead:</thead>,<tbody:</tbody>,<tr:</tr>,<:>,<tag>:/tag>'
autocmd FileType html   let b:match_words='<div:</div>,<script:</script>,<table:</table>,<form:</form>,<thead:</thead>,<tbody:</tbody>,<tr:</tr>,<:>,<tag>:/tag>'

" }}}

" Ansible {{{

let g:ansible_attribute_highlight='ab'
let g:ansible_name_highlight='b'
let g:ansible_exxtra_keywords_highlight=1
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_with_keywords_highlight = 'Constant'

" }}}

" }}}

" }}}

" Make vim use triple bracket fold markers in vimrc
" vim:foldmethod=marker
