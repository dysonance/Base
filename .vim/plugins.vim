" Setup {{{

let $PYTHON_VERSION='3.8'
let $PYTHON_BINARY=$HOME."/.pyenv/versions/3.8.6/bin/python3"

set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

" }}}

" List {{{

" Editing Utilities {{{

Plug 'Raimondi/delimitMate'       " (smarter) auto-insertion of brackets/quotes
"Plug 'jiangmiao/auto-pairs'       " auto-insertion of brackets/quotes
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
Plug 'python-rope/ropevim'            " python refactoring tools

" }}}

" Language Support {{{

Plug 'JuliaEditorSupport/julia-vim'                " julia language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " go language support
Plug 'vim-scripts/Vim-R-plugin'                    " R language support improved
Plug 'plasticboy/vim-markdown'                     " Markdown language support
Plug 'hashivim/vim-terraform'                      " basic vim/terraform integration
Plug 'pearofducks/ansible-vim'                     " common ansible filetypes (j2, hosts, certain yaml)
Plug 'mattn/emmet-vim'                             " web design workflow utilities
Plug 'pangloss/vim-javascript'                     " js syntax and indentation support

"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' } " python workflow utilities (linting, completion, formatting)

" Linting/Completion {{{

"Plug 'Valloric/YouCompleteMe'     " code completion functionality (see pre-requisites on GitHub)
"Plug 'vim-syntastic/syntastic'        " Linter/syntax checker for Vim
"Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" }}}

" }}}

call plug#end()

" }}}

" Optional {{{

runtime macros/matchit.vim  " extended `%` logical navigation

" }}}

" Configuration {{{

" Coc {{{

nmap <leader>cd :CocList diagnostics<CR>
nmap <leader>cr :CocRestart<CR>

imap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
imap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

"inoremap <silent><expr> <Tab>
"            \ coc#pum#visible() ? coc#pum#next(1) :
"            \ CheckBackspace() ? "\<Tab>" :
"            \ coc#refresh()

" }}}

" ALE {{{

let g:ale_completion_enabled=0    " leave completion to coc-vim
let g:ale_completion_autoimport=1 " automatically import external modules when linting
let g:ale_lint_on_text_changed=0  " stop constant linting on the fly before finishing a thought
let g:ale_lint_on_insert_leave=1  " run linters after leaving insert mode
let g:ale_lint_on_enter=1         " run linters when opening a new file
let g:ale_lint_on_save=1          " run linters when saving files

"set completeopt=menu,menuone,preview,noselect,noinsert  " see :h ale-completion-completeopt-bug
"set omnifunc=ale#completion#OmniFunc

" linting
let g:ale_open_list=0
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=0
let g:ale_linters=
            \ {
            \ 'python': ['flake8', 'pylint'],
            \ 'javascript': ['eslint'],
            \ 'vue': ['vls'],
            \ 'cpp': ['clang', 'clangd']
            \ }
" python
let g:ale_python_pylint_options='--rcfile=~/.config/pylint.cfg'
let g:ale_python_flake8_options='--config /usr/local/share/flake8.cfg'
let g:ale_python_auto_pipenv=1
let g:ale_python_pylint_auto_pipenv=1
let g:ale_python_flake8_auto_pipenv=1
" c/cpp
let g:ale_cpp_clang_options='-I/usr/local/opt/llvm/include/c++/v1 -L/usr/local/opt/llvm/lib'
let g:ale_cpp_clangd_options='--clang-tidy --suggest-includes --pch-storage=disk'
" go
let g:ale_go_golint_executable=''

" }}}

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
            \ 'error strings should not be capitalized or end with punctuation',
            \ '#pragma once in main file'
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
let g:syntastic_python_checkers=['python3', 'flake8', 'pylint']
let g:syntastic_python_pylint_args=' --rcfile=~/.config/pylint.cfg'
let g:syntastic_python_flake8_args=' --config /usr/local/share/flake8.cfg'

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

" {{{ Pear Tree 

let g:pear_tree_repeatable_expand=0

" }}}

" delimitMate {{{

let g:delimitMate_expand_cr=1
let g:delimitMate_expand_space=1
let g:delimitMateAutoClose=1
let g:delimitMate_jump_expansion=1

" }}}

" Auto-Pairs {{{

" " NOTE: including angle brackets will mess with greater than / less than
" let g:AutoPairs={'(' : ')', '[' : ']', '{' : '}',"'" : "'",'"' : '"', '`' : '`', '<' : '>'}
" let g:AutoPairsMoveCharacter="()[]{}<>\"'"

" }}}

" Git Gutter {{{

let g:gitgutter_realtime=0 " dont update gutter in realtime to stop lag (will update on save)
let g:gitgutter_set_sign_backgrounds=0

highlight! link SignColumn LineNr
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

"let g:slime_default_config = {"socket_name": "default", "target_pane": "3"}

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

let g:closetag_filenames='*.html,*.tpl,*.vue' " filetypes that activate the plugin
let g:closetag_shortcut='>'             " shortcut for closing tags
let g:closetag_close_shortcut=''        " add > at current position w/o closing current tag

" }}}

" Matchit {{{

autocmd filetype html   let b:match_words='<div:</div>,<script:</script>,<table:</table>,<form:</form>,<thead:</thead>,<tbody:</tbody>,<tr:</tr>,<:>,<tag>:/tag>'
autocmd filetype smarty let b:match_words='<div:</div>,<script:</script>,<table:</table>,<form:</form>,<thead:</thead>,<tbody:</tbody>,<tr:</tr>,<:>,<tag>:/tag>'
autocmd filetype vue    let b:match_words='<div:</div>,<script:</script>,<table:</table>,<form:</form>,<thead:</thead>,<tbody:</tbody>,<tr:</tr>,<:>,<tag>:/tag>,<template>:</template>'

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
