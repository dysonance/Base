" Setup {{{

set rtp+=$HOME/.vim
set rtp+=$HOME/.vim/autoload/plug.vim
set rtp+=$HOME/.vim/after
set rtp+=$HOME/go/src/github.com/golang/lint/misc/vim

source $HOME/.vim/packages.vim

if has('python3')
    silent! python3 1
endif

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

colorscheme dysonance                                             " colorscheme of choice
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
set expandtab                                   " coerce tabs to spaces
autocmd FileType r setlocal tabstop=2           " R-language specific formatting settings
autocmd FileType r setlocal softtabstop=2       " R-language specific formatting settings
autocmd FileType r setlocal shiftwidth=2        " R-language specific formatting settings
autocmd FileType fortran setlocal shiftwidth=3  " fortran-specific formatting settings
autocmd FileType fortran setlocal tabstop=3     " fortran-specific formatting settings
autocmd FileType fortran setlocal softtabstop=3 " fortran-specific formatting settings
autocmd FileType md setlocal spell              " dont check spelling in markdown files
autocmd FileType pandoc setlocal spell          " dont check spelling in markdown files
set backspace=indent,eol,start                  " make backspace work like most apps

" }}}

" }}}

" Functional Tweaks {{{

set mouse=a                    " enable use of scrolling with the mouse
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
autocmd FileType python set foldmethod=indent " overwrite pymode indent method

" }}}

" code formatting options

autocmd FileType sql setlocal formatprg=/usr/local/bin/pg_format\ -\ --keyword-case\ 1\ --function-case\ 1
autocmd FileType r setlocal formatprg=/usr/bin/python\ $R_LIBS_USER/rfmt/python/rfmt.py\ \--margin1\ 120\ --indent\ 2\ --space_arg_eq\ False
autocmd FileType fortran setlocal formatprg=/usr/local/bin/fprettify\ --silent\ -
autocmd FileType python setlocal formatprg=black\ --line-length\ 120\ --quiet\ -
autocmd FileType cpp setlocal formatprg=/usr/local/bin/clang-format\ -style=file\ -
autocmd FileType css setlocal formatprg=/usr/local/bin/prettier\ --parser\ css\ --stdin\ -
autocmd FileType html setlocal formatprg=/usr/local/bin/tidy\ -config\ $HOME/.tidyrc

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
nnoremap > >>
nnoremap < <<

" shortcut to delete line
nnoremap D dd

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
autocmd FileType sql nmap <leader>fmt m0gggqG`0
autocmd FileType cpp nmap <leader>fmt :ClangFormat<CR>
autocmd FileType python nmap <leader>fmt mmgggqG`m
autocmd FileType go nmap <leader>fmt :GoFmt<CR>
autocmd FileType css nmap <leader>fmt :!prettier --write --parser css %<CR><CR>
autocmd FileType html nmap <leader>fmt :!tidy -config ~/.tidyrc %<CR><CR>
autocmd FileType tpl nmap <leader>fmt :!tidy -config ~/.tidyrc %<CR><CR>

" quick isolation of the currently focused file
nnoremap <leader><Esc><Esc> :only<CR>

" merge conflict resolution shortcuts
nmap <leader>dgr :diffget REMOTE \| diffupdate<CR>
nmap <leader>dgl :diffget LOCAL \| diffupdate<CR>
nmap <leader>dgb :diffget BASE \| diffupdate<CR>

" Local (within scope) variable replacement
nnoremap <leader>fr :%s/\<<C-r><C-w>\>//g<Left><Left>

" Find/highlight usages of variable
nmap <leader>fu gd``

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
nnoremap <leader>gdm :Gdiff master<CR>zRgg]czz

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

" Visual Mode {{{

" reselct visual selection after incrementing or decrementing numbers
vnoremap <C-A> <C-A>gv
vnoremap <C-X> <C-X>gv

" }}}

" Normal Mode {{{

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

" Insert Mode {{{

autocmd FileType pandoc vmap <C-J> <Esc>f{vi{
autocmd FileType pandoc imap <C-J> <Esc>f{vi{
autocmd FileType pandoc nmap <C-J> <Esc>f{vi{
autocmd FileType pandoc imap <C-L> _{}<Esc>i
autocmd FileType pandoc imap <C-E> ^{}<Esc>i
autocmd Filetype pandoc imap <C-F> \text{}<Esc>i
autocmd FileType pandoc imap <C-T>s \sum\limits_{i=1}^{N}<Esc>F=vi{
autocmd FileType pandoc imap <C-T>p \prod\limits_{i=1}^{N}<Esc>F=vi{
autocmd FileType pandoc imap <C-T>f \frac{1}{N}<Esc>F1v
autocmd FileType pandoc imap <C-T>tf \tfrac{1}{N}<Esc>F1v
autocmd FileType pandoc imap <C-B> \left<C-V>[\right<C-V>]<Esc>%a<Space><Space><Esc>i
autocmd FileType pandoc imap <C-P> \left<C-V>(\right<C-V>)<Esc>%a<Space><Space><Esc>i

autocmd FileType pandoc imap <C-G>a \alpha
autocmd FileType pandoc imap <C-G>b \beta
autocmd FileType pandoc imap <C-G>s \sigma
autocmd FileType pandoc imap <C-G>g \gamma
autocmd FileType pandoc imap <C-G>m \mu
autocmd FileType pandoc imap <C-G>f \phi
autocmd FileType pandoc imap <C-G>p \pi
autocmd FileType pandoc imap <C-G>w \omega
autocmd FileType pandoc imap <C-G>A \Alpha
autocmd FileType pandoc imap <C-G>B \Beta
autocmd FileType pandoc imap <C-G>S \Sigma
autocmd FileType pandoc imap <C-G>G \Gamma
autocmd FileType pandoc imap <C-G>m \Mu
autocmd FileType pandoc imap <C-G>F \Phi
autocmd FileType pandoc imap <C-G>P \Pi
autocmd FileType pandoc imap <C-G>W \Omega

" }}}

" }}}

" F-Key Mappings {{{

"nmap <F1> K
nmap <silent> <F1> <Plug>DashSearch
nmap <silent> <leader>dd <Plug>DashSearch

autocmd FileType pandoc nnoremap <F4> :!pandoc % -o %:r.pdf --verbose<CR>
autocmd FileType pandoc nnoremap <F5> :!pandoc % -o %:r.pdf --verbose && open %:r.pdf<CR>

nnoremap <leader><F3> :execute ":SlimeSend1 TEST"<CR>
nnoremap <leader><F4> :execute ":SlimeSend1 BUILD"<CR>
nnoremap <leader><F5> :execute ":SlimeSend1 RUN"<CR>

autocmd FileType r nmap <silent> <leader><F1> :!R -e "?<cword>"<CR>
autocmd FileType r nmap <F4> :execute ":SlimeSend1 build r" . bufname("%") . "')"<CR>
autocmd FileType r nmap <F5> :execute ":SlimeSend1 source('" . bufname("%") . "')"<CR>
autocmd FileType r nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType r vmap <F6> :SlimeSend<CR>gv
autocmd FileType r nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType r nmap <F8> :SlimeSendCurrentLine<CR>

autocmd FileType julia nmap <F3> :execute ":SlimeSend1 julia --color=yes -e \"using Pkg; Pkg.test(\\\"" . getcwd() . "\\\")\""<CR>
autocmd FileType julia nmap <F4> :execute ":SlimeSend1 julia -O3 --color=yes " . bufname("%")<CR>
autocmd FileType julia nmap <F5> :execute ":SlimeSend1 include(\"" . bufname("%") . "\")"<CR>
autocmd FileType julia nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType julia vmap <F6> :SlimeSend<CR>gv
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
autocmd FileType sh vmap <F6> :SlimeSend<CR>gv
autocmd FileType sh nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType sh nmap <F8> :SlimeSendCurrentLine<CR>

autocmd FileType sql nmap <silent> <leader><F1> :!psql postgres -c "\\h <cword>"<CR>
autocmd FileType sql nmap <F5> :execute ":SlimeSend1 \\i " . bufname("%") . ""<CR>
autocmd FileType sql nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType sql vmap <F6> :SlimeSend<CR>gv
autocmd FileType sql nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType sql nmap <F8> :SlimeSendCurrentLine<CR>

autocmd FileType python nmap <silent> <leader><F1> :!ipython -c "?<cword>"<CR>
autocmd FileType python nmap <F3> :execute ":SlimeSend1 test python"<CR>
autocmd FileType python nmap <F4> :execute ":SlimeSend1 build python"<CR>
autocmd FileType python nmap <F5> :execute ":SlimeSend1 exec(open('" . bufname("%") . "').read())"<CR>
autocmd FileType python nmap <F6> msvip:SlimeSend<CR>`s
autocmd FileType python vmap <F6> :SlimeSend<CR>gv
autocmd FileType python nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd FileType python nmap <F8> :SlimeSendCurrentLine<CR>

" }}}

" }}}

" Miscellaneous Preferences {{{

" lzz files interpreted as cpp files
autocmd BufNewFile,BufRead *.lzz set filetype=cpp

" treat yaml files uniquely with regards to indenting
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" }}}

" Make vim use triple bracket fold markers in vimrc
" vim:foldmethod=marker:foldlevel=0
