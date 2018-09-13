" Version Management {{{

if has('python3')
    silent! python3 1
endif

" }}}

" Package Manager Setup {{{

set nocompatible

filetype off
set rtp+=$HOME/.vim
set rtp+=$HOME/.vim/autoload/plug.vim
set rtp+=$HOME/.vim/after
set rtp+=$HOME/go/src/github.com/golang/lint/misc/vim
call plug#begin('~/.vim/plugged')

" Plugin List {{{


" Editing Utilities

Plug 'jiangmiao/auto-pairs'     " auto-insertion of brackets/quotes
Plug 'tpope/vim-surround'       " easily surround chunks of text with delimiters
Plug 'Valloric/YouCompleteMe'   " code completion functionality (see pre-requisites on GitHub)
Plug 'scrooloose/nerdcommenter' " comment adding utility
Plug 'junegunn/vim-easy-align'  " align blocks of code easily
Plug 'rhysd/vim-clang-format'   " clang format whole file
Plug 'ambv/black'               " python formatter


" Workflow Utilities

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


" Language Support

Plug 'octol/vim-cpp-enhanced-highlight'            " more intelligent c++ syntax highlighting
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " go language support
Plug 'JuliaEditorSupport/julia-vim'                " Julia language support
Plug 'vim-scripts/Vim-R-plugin'                    " R language support improved
Plug 'plasticboy/vim-markdown'                     " Markdown language support
Plug 'vim-pandoc/vim-pandoc'                       " required for Rmd support
Plug 'vim-pandoc/vim-pandoc-syntax'                " required for Rmd support
Plug 'vim-pandoc/vim-rmarkdown'                    " support for RMarkdown and KnitR
Plug 'vim-python/python-syntax'                    " enhanced python syntax highlighting

" }}}

call plug#end()

" Optional Vim Packages {{{

runtime macros/matchit.vim  " extended `%` logical navigation

" }}}

" Package Configurations {{{

" Syntastic {{{

" General

" let g:syntastic_debug=3  " turn on to see diagnostics when checking
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors=1
let g:syntastic_enable_signs=1
let ignored_messages=
            \ [
            \ 'invalid preprocessing directive',
            \ 'should have comment or be unexported',
            \ 'receiver name should be a reflection of its identity',
            \ '[Ii][Dd] should be.*ID'
            \ ]
let g:syntastic_quiet_messages={"regex": ignored_messages}
autocmd filetype qf setlocal wrap

" C/C++
let g:syntastic_c_compiler='clang'
let g:syntastic_c_auto_refresh_includes=1

let g:syntastic_cpp_config_file='.syntastic_cpp_config'
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_auto_refresh_includes=1
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'

" Python
let g:syntastic_python_checkers=['python3', 'pyflakes']

" Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" }}}

" YouCompleteMe {{{

let g:ycm_complete_in_strings=0                       " dont autocomplete strings
let g:ycm_collect_identifiers_from_tags_files=1       " use the tags file from ctags command
let g:ycm_python_binary_path='/usr/local/bin/python3' " use python 3 instead of system python
let g:ycm_max_num_candidates=20                       " maximum number of completion options to use (default 50)
let g:ycm_min_num_identifier_candidate_chars=2        " min chars id candidate must have to appear
let g:ycm_confirm_extra_conf=0                        " dont ask to reload conf every time
set completeopt=menu,menuone                          " turn off the preview/documentation window
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_show_diagnostics_ui=0
let g:ycm_error_symbol='E'
let g:ycm_warning_symbol='W'
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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

let g:gitgutter_realtime=0  " dont update gutter in realtime to stop lag (will update on save)
set updatetime=100  " redo gutter git diff every 100 ms (1/10 sec)
"let g:gitgutter_sign_column_always=1  " keep the git gutter sign column on all the time (less distracting)
"set signcolumn=yes

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

let g:pandoc#command#autoexec_command="Pandoc pdf"
let g:pandoc#command#latex_engine="xelatex"
let g:pandoc#command#autoexec_on_writes=0
let g:pandoc#command#prefer_pdf=1

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

" }}}

" }}}

" Visual Tweaks {{{

filetype plugin indent on " enable filetype plugins and indentations
syntax enable             " enable syntax highlighting

" Status Line Tweakes {{{

set laststatus=2
set statusline=
set statusline +=%*\ %n\ %* " buffer number
set statusline +=%*%{&ff}%* " file format
set statusline +=%*%y%*     " file type
set statusline +=%*\ %<%F%* " full path
set statusline +=%*%m%*     " modified flag
set statusline +=%*%=%5l%*  " current line
set statusline +=%*/%L%*    " total lines
set statusline +=%*%4v\ %*  " virtual column number

" }}}

" General Tweaks {{{

colorscheme jamos_blue                                             " colorscheme of choice
syntax match customTodo contained '\<\(TODO\|FIXME\|NOTE\|XXX\)\>' " add words for todo highlights
hi def link customTodo Todo
set number                                                         " show line numbers
set cino+=(0                                                       " align function arguments
set nowrap                                                         " stop line wrapping
set showcmd                                                        " show last entered command in bottom bar
set lazyredraw                                                     " redraw only when necessary
set showmatch                                                      " highlight matching brackets/parens
set mat=1                                                          " 1/10 of a second to blink when matching brackets
set noerrorbells                                                   " no audible bell on errors
set cursorline                                                     " highlight line (next cmd removes underline)
set hlsearch                                                       " highlight search results

" }}}

" Tabs And Whitespace {{{

set tabstop=4                                   " number of visual spaces per tab
set softtabstop=4                               " number of spaces in tab when editing
set shiftwidth=4                                " number of columns for reindent operations (<< and >>)
autocmd FileType r setlocal tabstop=2           " R-language specific formatting settings
autocmd FileType r setlocal softtabstop=2       " R-language specific formatting settings
autocmd FileType r setlocal shiftwidth=2        " R-language specific formatting settings
autocmd FileType fortran setlocal shiftwidth=3  " fortran-specific formatting settings
autocmd FileType fortran setlocal tabstop=3     " fortran-specific formatting settings
autocmd FileType fortran setlocal softtabstop=3 " fortran-specific formatting settings
autocmd FileType Rmd setlocal nospell           " dont check spelling in rmarkdown files
autocmd FileType md setlocal nospell            " dont check spelling in markdown files
autocmd FileType pandoc setlocal nospell        " dont check spelling in markdown files
set backspace=indent,eol,start                  " make backspace work like most apps
set expandtab                                   " tabs are spaces

" }}}

" }}}

" Functional Tweaks {{{

set noswapfile                 " dont create temporary swap files
set autoindent                 " keep indent from current line when starting new line
set smartindent                " make indenting logic smarter using language syntax
set ruler                      " always show the current cursor position
set incsearch                  " make search act like in modern web browsers
set autoread                   " automatically read when a file is changed externally
set regexpengine=1             " newer regular expression engine (versions 7.4+)
autocmd VimResized * :wincmd = " automatically resize scale windows when terminal is resized
if has("clipboard")
  set clipboard=unnamed        " copy to system clipboard
endif
if &diff
    set diffopt+=iwhite        " ignore whitespace in diff mode but not in standard vim
endif


" Code Folding {{{

set foldenable                                " enable code folding
set foldmethod=indent                         " fold based on language syntax
set foldlevelstart=99                         " fold level at file open (0=everything folded, 99=nothing)
set foldnestmax=99                            " maximum fold nesting
set modelines=1                               " check last line of file for a modeline so vimrc can be folded
let r_syntax_folding=1                        " allow syntax folding in the Vim-R plugin
autocmd FileType python set foldmethod=indent " overwrite pymode indent method

" }}}

" code formatting options
autocmd FileType sql setlocal formatprg=/usr/local/bin/pg_format\ -\ --keyword-case\ 2\ --function-case\ 3
autocmd FileType r setlocal formatprg=/usr/bin/python\ $R_LIBS_USER/rfmt/python/rfmt.py\ \--margin1\ 120\ --indent\ 2\ --space_arg_eq\ False
autocmd FileType fortran setlocal formatprg=/usr/local/bin/fprettify\ --silent\ -
autocmd FileType python setlocal formatprg=/usr/local/bin/autopep8\ -
autocmd FileType cpp setlocal formatprg=/usr/local/bin/clang-format\ -style=file\ -
autocmd FileType css setlocal formatprg=/usr/local/bin/prettier\ --parser\ css\ --stdin\ -

" }}}

" Key Mappings {{{

" General Mappings {{{

" refactoring / variable replacement
" local (scope) refactor
nmap gr gd[{V%::s/<C-R>///gc<Left><Left><Left>
autocmd FileType python nmap gr gdViM::s/<C-R>///gc<Left><Left><Left>
" global refactor
nmap gR gDVG::s/<C-R>///gc<Left><Left><Left>

" Global variable replacement
"nnoremap gR gD::%s/<C-R>///gc<left><left><left>

" shortcut to replace word by pasting before it, deleting it, and adding a space
nnoremap R Pldwi<Esc>bye

" Undo the Vim R plugin annoying underscore to arrow mapping
let vimrplugin_assign=0

" space toggles current fold
nnoremap <space> za

" visually select text entered when last in insert mode
nnoremap gV [v`]

" make the `#` key still use `n` to move forward and `N` to move backwards
nnoremap # *NN

" re-select visual block after indenting
" (normally vim will deselect and go back to normal mode)
vnoremap < <gv
vnoremap > >gv

" fast pane splitting and focus switching
nnoremap <expr><silent> \| !v:count ? "<C-W>v<C-W><Right>" : '\|'
nnoremap <expr><silent> _ !v:count ? "<C-W>s<C-W><Down>"  : '_'
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W

" ctrl+h to turn off highlighting
nnoremap <Esc><Esc> :nohl<CR>

" easy align initializer keymap
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }}}

" Leader Mappings {{{

" easier auto-pairs prevention shortcut
imap <C-P> <C-V>

" format current file
autocmd FileType cpp nmap <leader>fmt :ClangFormat<CR>
autocmd FileType python nmap <leader>fmt :Black<CR>
autocmd FileType css nmap <leader>fmt :!prettier --write --parser css %<CR><CR>
autocmd FileType go nmap <leader>fmt :GoFmt<CR>

" quick isolation of the currently focused file
nnoremap <leader><Esc><Esc> :only<CR>

" merge conflict resolution shortcuts
nmap <leader>dgr :diffget REMOTE \| diffupdate<CR>
nmap <leader>dgl :diffget LOCAL \| diffupdate<CR>
nmap <leader>dgb :diffget BASE \| diffupdate<CR>

" Local (within scope) variable replacement
nnoremap <leader>fr :%s/\<<C-r><C-w>\>//g<Left><Left>

" vim line diff plugin shortcuts
vnoremap <leader>ldf :Linediff<CR>
nnoremap <leader>ldr :LinediffReset<CR>

" lzz shortcut
nnoremap <leader>lzz :!lzz %<CR><CR>
nnoremap <leader>LZZ :!find `git root` \| grep \"\\.lzz\" \| xargs lzz

" git add entire current file to staged index
nnoremap <leader>ga :!git add %<CR><CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :!git push<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gdf :Gdiff<CR>
nnoremap <leader>gdm :Gdiff master<CR>

" easier grepper command accessibility
nnoremap <leader>gr :Grepper<CR>

" search for next git merge conflict
nnoremap <leader>mc /\<HEAD\>\\|<<<<\\|>>>>\\|====\\|\|\|\|\|<CR>

" easier error jumping
nnoremap <leader>ne :lne<CR>
nnoremap <leader>pe :lN<CR>

" syntastic reset shortcut
nnoremap <leader>sr :SyntasticReset<CR>
nnoremap <leader>st :SyntasticToggleMode<CR>

" }}}

" Control Key Mappings {{{

" reselct visual selection after incrementing or decrementing numbers
vnoremap <C-A> <C-A>gv
vnoremap <C-X> <C-X>gv

" toggle the nerd tree side bar file explorer menu
nnoremap <C-N> :NERDTreeToggle<CR>

" faster buffer/tab navigation
nnoremap <C-J> :b#<CR>
nnoremap <C-H> :bprevious<CR>
nnoremap <C-L> :bnext<CR>
nnoremap <C-K> :bdelete<CR>

" ctrl+t to access terminal
nnoremap <C-T> :shell<CR>

" }}}

" F-Key Mappings {{{

"nmap <F1> K
nmap <silent> <F1> <Plug>DashSearch
nmap <silent> <leader>dd <Plug>DashSearch

autocmd FileType pandoc nnoremap <F4> :!pandoc % -o %:r.pdf --verbose --listings --number-sections --table-of-contents --variable=geometry:margin=1in<CR>
autocmd FileType pandoc nnoremap <F5> :!pandoc % -o %:r.pdf --verbose --listings --number-sections --table-of-contents --variable=geometry:margin=1in && open %:r.pdf<CR>

nnoremap <leader><F3> :execute ":SlimeSend1 TEST"<CR>
nnoremap <leader><F4> :execute ":SlimeSend1 BUILD"<CR>
nnoremap <leader><F5> :execute ":SlimeSend1 RUN"<CR>

autocmd FileType r nmap <silent> <leader><F1> :!R -e "?<cword>"<CR>
autocmd FileType r nmap <F4> :execute ":SlimeSend1 build r" . bufname("%") . "')"<CR>
autocmd FileType r nmap <F5> :execute ":SlimeSend1 source('" . bufname("%") . "')"<CR>
autocmd FileType r nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType r vmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType r nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType r nmap <F8> :SlimeSendCurrentLine<CR>

autocmd FileType julia nmap <F3> :execute ":SlimeSend1 julia --color=yes -e \"Pkg.test(\\\"" . getcwd() . "\\\")\""<CR>
autocmd FileType julia nmap <F5> :execute ":SlimeSend1 include(\"" . bufname("%") . "\")"<CR>
autocmd FileType julia nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType julia vmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType julia nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType julia nmap <F8> :SlimeSendCurrentLine<CR>

autocmd FileType cpp set keywordprg=cppman
autocmd FileType cpp nmap <silent> <leader><F1> :!cppman <cword><CR>
autocmd FileType cpp nmap <F3> :execute ":SlimeSend1 test cpp"<CR>
autocmd FileType cpp nmap <F4> :execute ":SlimeSend1 build cpp"<CR>
autocmd FileType cpp nmap <F5> :execute ":SlimeSend1 run cpp"<CR>

autocmd FileType sh nmap <silent> <leader><F1> :!man <cword><CR>
autocmd FileType sh nmap <F4> :execute ":SlimeSend1 ./" . bufname("%") . ""<CR>
autocmd FileType sh nmap <F5> :execute ":SlimeSend1 . " . bufname("%") . ""<CR>
autocmd FileType sh nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType sh vmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType sh nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType sh nmap <F8> :SlimeSendCurrentLine<CR>

autocmd FileType sql nmap <silent> <leader><F1> :!psql postgres -c "\\h <cword>"<CR>
autocmd FileType sql nmap <F5> :execute ":SlimeSend1 \\i " . bufname("%") . ""<CR>
autocmd FileType sql nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType sql vmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType sql nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType sql nmap <F8> :SlimeSendCurrentLine<CR>

autocmd FileType python nmap <silent> <leader><F1> :!ipython -c "?<cword>"<CR>
autocmd FileType python nmap <F3> :execute ":SlimeSend1 test python"<CR>
autocmd FileType python nmap <F4> :execute ":SlimeSend1 build python"<CR>
autocmd FileType python nmap <F5> :execute ":SlimeSend1 exec(open('" . bufname("%") . "').read())"<CR>
autocmd FileType python nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType python vmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType python nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType python nmap <F8> :SlimeSendCurrentLine<CR>

" }}}

" }}}

" Miscellaneous Preferences {{{

" lzz files interpreted as cpp files
autocmd BufNewFile,BufRead *.lzz set filetype=cpp

" }}}

" Make vim use triple bracket fold markers in vimrc
" vim:foldmethod=marker:foldlevel=0
