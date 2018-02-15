" Package Manager Setup {{{
set nocompatible

filetype off
set rtp=$HOME/Applications/vim/runtime
set rtp+=$HOME/.vim
set rtp+=$HOME/.vim/autoload/plug.vim
set rtp+=$HOME/go/src/github.com/golang/lint/misc/vim
call plug#begin('~/.vim/plugged')

" Plugin List {{{

Plug 'VundleVim/Vundle.vim'  " Vundle plugin management

" editing utilities
Plug 'jiangmiao/auto-pairs'     " auto-insertion of brackets/quotes
Plug 'tpope/vim-surround'       " easily surround chunks of text with delimiters
Plug 'Valloric/YouCompleteMe'   " code completion functionality (see pre-requisites on GitHub)
Plug 'scrooloose/nerdcommenter' " comment adding utility
Plug 'junegunn/vim-easy-align'  " align blocks of code easily

" workflow utilities
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

" language support
Plug 'octol/vim-cpp-enhanced-highlight' " more intelligent c++ syntax highlighting
Plug 'fatih/vim-go'                     " go language support
Plug 'JuliaEditorSupport/julia-vim'     " Julia language support
Plug 'vim-scripts/Vim-R-plugin'         " R language support improved
"Plug 'jalvesaq/Nvim-R'                  " R language communication with console
Plug 'plasticboy/vim-markdown'          " Markdown language support
Plug 'vim-pandoc/vim-pandoc'            " required for Rmd support
Plug 'vim-pandoc/vim-pandoc-syntax'     " required for Rmd support
Plug 'vim-pandoc/vim-rmarkdown'         " support for RMarkdown and KnitR
Plug 'rhysd/vim-clang-format'           " clang auto-formatting for certain languages

" }}}

call plug#end()

" }}}

" Visual Tweaks {{{
filetype plugin indent on  " enable filetype plugins and indentations
syntax enable  " enable syntax highlighting
set term=screen-256color

" status line tweakes
set laststatus=2
set statusline=
set statusline +=%*\ %n\ %*            "buffer number
set statusline +=%*%{&ff}%*            "file format
set statusline +=%*%y%*                "file type
set statusline +=%*\ %<%F%*            "full path
set statusline +=%*%m%*                "modified flag
set statusline +=%*%=%5l%*             "current line
set statusline +=%*/%L%*               "total lines
set statusline +=%*%4v\ %*             "virtual column number

" general tweaks
colorscheme jamos_blue  " colorscheme of choice
set number  " show line numbers
set cino+=(0  " align function arguments
set nowrap  " stop line wrapping
set showcmd  " show last entered command in bottom bar
set lazyredraw  " redraw only when necessary
set showmatch  " highlight matching brackets/parens
set mat=1  " 1/10 of a second to blink when matching brackets
set noerrorbells  " no audible bell on errors
set cursorline  " highlight line (next cmd removes underline)
hi CursorLine cterm=NONE
set hlsearch  " highlight search results

" tabs and whitespace {{{
set tabstop=4  " number of visual spaces per tab
set softtabstop=4  " number of spaces in tab when editing
set shiftwidth=4  " number of columns for reindent operations (<< and >>)
autocmd FileType r set tabstop=2  " R-language specific formatting settings
autocmd FileType r set softtabstop=2  " R-language specific formatting settings
autocmd FileType r set shiftwidth=2  " R-language specific formatting settings
autocmd FileType Rmd set nospell  " dont check spelling in rmarkdown files
autocmd FileType md set nospell  " dont check spelling in markdown files
set backspace=indent,eol,start  " make backspace work like most apps
set expandtab  " tabs are spaces

" }}}
" }}}

" Functional Tweaks {{{

set noswapfile  " dont create temporary swap files
set autoindent
set smartindent

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed  " copy to system clipboard
"  if has("unnamedplus")  " X11 support
"    set clipboard+=unnamedplus
"  endif
endif

set ruler  " always show the current cursor position
set incsearch  " make search act like in modern web browsers
set autoread  " automatically read when a file is changed externally
set regexpengine=1  " newer regular expression engine (versions 7.4+)

" automatically resize scale windows when terminal is resized
autocmd VimResized * :wincmd =

" code folding
set foldenable  " enable code folding
set foldmethod=syntax " fold based on language syntax
set foldlevelstart=99  " fold level at file open (0=everything folded, 99=nothing)
set foldnestmax=99  " maximum fold nesting
set modelines=1  " check last line of file for a modeline so vimrc can be folded
let r_syntax_folding=1  " allow syntax folding in the Vim-R plugin

" ignore whitespace in diff mode but not in standard vim
if &diff
    set diffopt+=iwhite
endif

" }}}

" Key Mappings {{{

" General Mappings {{{

" Global variable replacement
"nnoremap gR gD::%s/<C-R>///gc<left><left><left>

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

" Local (within scope) variable replacement
nnoremap <leader>fr :%s/\<<C-r><C-w>\>//g<Left><Left>

" syntastic reset shortcut
nnoremap <leader>sr :SyntasticReset<CR>
nnoremap <leader>st :SyntasticToggleMode<CR>

" clang format shortcut
nnoremap <leader>cf :ClangFormat<CR>

" lzz shortcut
nnoremap <leader>lzz :!lzz %<CR><CR>

" git add entire current file to staged index
nnoremap <leader>ga :!git add %<CR><CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :!git push<CR>

vnoremap <leader>ldf :Linediff<CR>
nnoremap <leader>ldr :LinediffReset<CR>

" Convert each name_like_this to nameLikeThis in current line
" (convert *s*nake case to *c*amel case)
nnoremap <leader>sc :s#_\(\l\)#\u\1#g<CR>

" go to definition in golang
nnoremap <leader>gd :GoDef<CR>

" easier grepper command accessibility
nnoremap <leader>gr :Grepper<CR>

" easier error jumping
nnoremap <leader>ne :lne<CR>
nnoremap <leader>pe :lN<CR>

" quick isolation of the currently focused file
nnoremap <leader><Esc><Esc> :only<CR>

" }}}

" Control Key Mappings {{{

" reselct visual selection after incrementing or decrementing numbers
vnoremap <C-A> <C-A>gv
vnoremap <C-X> <C-X>gv

" toggle the nerd tree side bar file explorer menu
nnoremap <C-N> :NERDTreeToggle<CR>

" faster buffer management
nnoremap <C-L> :bn<CR>
nnoremap <C-H> :bp<CR>
nnoremap <C-K> :bd<CR>

" ctrl+t to access terminal
nnoremap <C-T> :shell<CR>

" }}}

" }}}

" Package Configurations {{{

" " Nvim-R {{{
" let R_in_buffer=0
" let R_applescript=0
" let R_tmux_split=1
" " }}}

" {{{Auto-Pairs Settings

" let g:AutoPairs={'(' : ')', '[' : ']', '{' : '}',"'" : "'",'"' : '"', '`' : '`', '<' : '>'}
" let g:AutoPairsMoveCharacter="()[]{}<>\"'"

" }}}

" Git Gutter Settings {{{
let g:gitgutter_realtime=0  " dont update gutter in realtime to stop lag (will update on save)
set updatetime=100  " redo gutter git diff every 100 ms (1/10 sec)
"let g:gitgutter_sign_column_always=1  " keep the git gutter sign column on all the time (less distracting)
set signcolumn=yes
" }}}

" Syntastic Settings{{{
" General
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors=1
let g:syntastic_enable_signs=1

" R (these are all annoying formatting things)
" let g:syntastic_enable_r_lintr_checker=0
" let g:syntastic_r_checkers=['lintr']

" C++ / Rcpp / RcppArmadillo
let g:syntastic_cpp_include_dirs=[
            \'/Library/Frameworks/R.framework/Resources/include',
            \'/usr/local/include',
            \'/Users/jacobamos/gitbase/goose_cpp/include/armadillo-7.960.1/include',
            \'/Users/jacobamos/gitbase/goose_cpp/include/googletest-release-1.8.0/googletest/include',
            \'/Users/jacobamos/gitbase/goose_cpp/include/gsl-2.4/include',
            \'/Users/jacobamos/gitbase/goose_cpp/src',
            \'/Users/jacobamos/gitbase/goose_cpp/src/goose',
            \'/Users/jacobamos/R_LIBS/RcppArmadillo/include',
            \'/Users/jacobamos/R_LIBS/Rcpp/include',
            \'/Users/jacobamos/gitbase/aaGoose/src'
            \]
let g:syntastic_cpp_check_header=1
let g:syntastic_c_compiler='clang'
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'
let g:syntastic_c_auto_refresh_includes=1
let g:syntastic_quiet_messages={"regex": 'invalid preprocessing directive\|should have comment or be unexported'}

" Go language
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

au Filetype go nnoremap <leader>v :vsplit <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :split <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

" }}}

" YouCompleteMe Settings{{{
let g:ycm_confirm_extra_conf=0  " dont ask to reload conf every time
let g:ycm_show_diagnostics_ui=0
let g:ycm_global_ycm_extra_conf='/Users/jacobamos/.ycm_extra_conf.py'
set completeopt=menu,menuone  " turn off the preview/documentation window
let g:ycm_autoclose_preview_window_after_insertion=1
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}}

" C++ Enhanced Highlighting {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
"let g:cpp_class_decl_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_experimental_template_highlight = 1
"let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1
" }}}

" {{{ Slime Settings
let g:slime_target="tmux"  " screen is the default
" }}}

" Clang Format {{{

let g:clang_format#detect_file_style=1

" }}}

" Nerd Tree {{{
"let loaded_netrwPlugin=1
let NERDTreeRespectWildIgnore=1
" }}}

" Nerd Commenter {{{

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" }}}

" {{{CtrlP

" show files in hidden/invisible folders
let g:ctrlp_show_hidden=1

" ignore git ignored files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" }}}

" }}}

" Miscellaneous Preferences {{{

" lzz files interpreted as cpp files
autocmd BufNewFile,BufRead *.lzz set filetype=cpp

" }}}

" Make vim use triple bracket fold markers in vimrc
" vim:foldmethod=marker:foldlevel=0
