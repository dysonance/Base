" Setup {{{

set rtp+=~/.vim
set rtp+=~/.vim/autoload/plug.vim

if !empty(glob("~/.vim/plugins.vim"))
    source $HOME/.vim/plugins.vim
endif

if has('python3')
    silent! python3 1
endif

" Templates/Skeletons {{{

augroup templates
    if !empty(glob("~/.vim/skeletons/skeleton.md"))
        autocmd BufNewFile *.md 0r ~/.vim/skeletons/skeleton.md
    endif
    if !empty(glob("~/.vim/skeletons/skeleton.lzz"))
        autocmd BufNewFile *.lzz 0r ~/.vim/skeletons/skeleton.lzz
    endif
    if !empty(glob("~/.vim/skeletons/skeleton.py"))
        autocmd BufNewFile *.py 0r ~/.vim/skeletons/skeleton.py
    endif
augroup END

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

if !empty(glob("~/.vim/colors/dysonance.vim"))
    colorscheme dysonance                                          " custom colorscheme
else
    colorscheme koehler                                            " universal colorscheme
endif
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
autocmd filetype r setlocal tabstop=2           " R-language specific formatting settings
autocmd filetype r setlocal softtabstop=2       " R-language specific formatting settings
autocmd filetype r setlocal shiftwidth=2        " R-language specific formatting settings
autocmd filetype fortran setlocal shiftwidth=3  " fortran-specific formatting settings
autocmd filetype fortran setlocal tabstop=3     " fortran-specific formatting settings
autocmd filetype fortran setlocal softtabstop=3 " fortran-specific formatting settings
"autocmd filetype md setlocal spell              " dont check spelling in markdown files
"autocmd filetype pandoc setlocal spell          " dont check spelling in markdown files
set backspace=indent,eol,start                  " make backspace work like most apps

" }}}

" }}}

" Functional Tweaks {{{

" General {{{

set mouse=a                                " enable use of scrolling with the mouse
set noswapfile                             " dont create temporary swap files
set autoindent                             " keep indent from current line when starting new line
set smartindent                            " make indenting logic smarter using language syntax
set ruler                                  " always show the current cursor position
set incsearch                              " make search act like in modern web browsers
set autoread                               " automatically read when a file is changed externally
set regexpengine=1                         " newer regular expression engine (versions 7.4+)
autocmd VimResized * :wincmd =             " automatically resize scale windows when terminal is resized
if has("clipboard")
  set clipboard=unnamed                    " copy to system clipboard
endif
if &diff
    set diffopt+=iwhite                    " ignore whitespace in diff mode but not in standard vim
endif
set timeout timeoutlen=500 ttimeoutlen=100 " reduce lag/delay when switching between modes

" " change cursor shape dynamically (see https://stackoverflow.com/a/30199177/2271756)
" if exists('$TMUX')
"   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" endif
" let &t_SI = "\e[5 q"
" let &t_EI = "\e[2 q"

" }}}

" Code Folding {{{

set foldenable                                " enable code folding
set foldmethod=indent                         " fold based on language syntax
set foldlevelstart=99                         " fold level at file open (0=everything folded, 99=nothing)
set foldnestmax=99                            " maximum fold nesting
set modelines=1                               " check last line of file for a modeline so vimrc can be folded
autocmd filetype python set foldmethod=indent " overwrite pymode indent method

" }}}

" Formatters {{{

autocmd filetype sql setlocal formatprg=pg_format\ -\ --keyword-case\ 2\ --function-case\ 3
autocmd filetype r setlocal formatprg=python\ $R_LIBS_USER/rfmt/python/rfmt.py\ \--margin1\ 120\ --indent\ 2\ --space_arg_eq\ False
autocmd filetype fortran setlocal formatprg=fprettify\ --silent\ -
autocmd filetype python setlocal formatprg=black\ --line-length\ 120\ --quiet\ -
autocmd filetype cpp setlocal formatprg=clang-format\ -style=file\ -
autocmd filetype css setlocal formatprg=prettier\ --parser\ css\ --stdin\ -
autocmd filetype html setlocal formatprg=tidy\ -config\ $HOME/.tidyrc


" }}

" }}}

" Key Mappings {{{

" General Mappings {{{

" refactoring / variable replacement
" local (scope) refactor
nmap gr gd[{V%::s/<C-R>///gc<Left><Left><Left>
autocmd filetype python nmap gr gdViM::s/<C-R>///gc<Left><Left><Left>
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

" re-select visual block after indenting/formatting
" (normally vim will deselect and go back to normal mode)
vnoremap < <gv
vnoremap > >gv
vnoremap gq gqgv
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

" case-insenstive word search
nnoremap <leader>* */\c<CR>

" join lines without whitespace
nnoremap <leader>j Ja<backspace><esc>

" convert camel case to snake case in current line
nnoremap <leader>sc :s#\(\<\u\l\+\|\l\+\)\(\u\)#\l\1_\l\2#g<CR>

" easier saving and quitting
nnoremap <silent> <leader>ss :w<CR>
nnoremap <silent> <leader>qq :q<CR>

" easier auto-pairs prevention shortcut
imap <C-P> <C-V>

" pivot split pane orientations
" vertical to horizontal
nmap <leader>pvh <C-W>t<C-W>K
" horizontal to vertical
nmap <leader>pvv <C-W>t<C-W>H

" format current file
autocmd filetype sql nmap <leader>fmt m0gggqG`0
autocmd filetype cpp nmap <leader>fmt :ClangFormat<CR>
autocmd filetype python nmap <leader>fmt mmgggqG`m
autocmd filetype go nmap <leader>fmt :GoFmt<CR>
autocmd filetype css nmap <leader>fmt :!prettier --write --parser css %<CR><CR>
autocmd filetype html nmap <leader>fmt :!tidy -config ~/.tidyrc %<CR><CR>
autocmd filetype tpl nmap <leader>fmt :!tidy -config ~/.tidyrc %<CR><CR>

" quick isolation of the currently focused file
nnoremap <leader><Esc><Esc> :only<CR>

" merge conflict resolution shortcuts
nnoremap <leader>dgr :diffget REMOTE \| diffupdate<CR>
nnoremap <leader>dgl :diffget LOCAL \| diffupdate<CR>
nnoremap <leader>dgb :diffget BASE \| diffupdate<CR>
nnoremap <leader>dgg :diffget \| diffupdate<CR>

" Local (within scope) variable replacement
nnoremap <leader>fr :%s/\<<C-R><C-W>\>//g<Left><Left>

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
nnoremap <leader>gdh :Gdiff HEAD<CR>
nnoremap <leader>gdm :Gdiff master<CR>zRgg]czz
nnoremap <leader>gdo :Gdiff 
nnoremap <leader>gda :Gdiff<Up><CR>

" easier grepper command accessibility
nnoremap <leader>gr :Grepper<CR>
nmap gr <plug>(GrepperOperator)
xmap gr <plug>(GrepperOperator)

" search for next git merge conflict
nnoremap <leader>mc /\<HEAD\>\\|<\{4,\}\\|>\{4,\}\\|=\{4,\}<CR>

" easier error jumping
nnoremap <leader>ne :lne<CR>
nnoremap <leader>pe :lN<CR>

" syntastic reset shortcut
nnoremap <leader>sr :SyntasticReset<CR>
nnoremap <leader>st :SyntasticToggleMode<CR>

" debugging shortcuts
autocmd filetype python nnoremap <leader>db Oimport ipdb; ipdb.set_trace()<esc>

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

" ctrl+s to save
nnoremap <silent> <C-S> :w<CR>

" ctrl+e to refresh file
nnoremap <silent> <C-E> :e<CR>

" ctrl+q to quit
nnoremap <silent> <C-Q> :q<CR>


" }}}

" Insert Mode {{{

" quickly save while in insert mode
inoremap <silent> <C-S> <Esc>:w<CR>a

" latex symbol shortcuts for pandoc markdown files
autocmd filetype pandoc vmap <C-J> <Esc>f{vi{
autocmd filetype pandoc imap <C-J> <Esc>f{vi{
autocmd filetype pandoc nmap <C-J> <Esc>f{vi{
autocmd filetype pandoc imap <C-L> _{}<Esc>i
autocmd filetype pandoc imap <C-E> ^{}<Esc>i
autocmd Filetype pandoc imap <C-F> \text{}<Esc>i
autocmd filetype pandoc imap <C-T>s \sum\limits_{i=1}^{N}<Esc>F=vi{
autocmd filetype pandoc imap <C-T>p \prod\limits_{i=1}^{N}<Esc>F=vi{
autocmd filetype pandoc imap <C-T>f \frac{1}{N}<Esc>F1v
autocmd filetype pandoc imap <C-T>tf \tfrac{1}{N}<Esc>F1v
autocmd filetype pandoc imap <C-B> \left<C-V>[\right<C-V>]<Esc>%a<Space><Space><Esc>i
autocmd filetype pandoc imap <C-P> \left<C-V>(\right<C-V>)<Esc>%a<Space><Space><Esc>i
autocmd filetype pandoc imap <C-C> \left<C-V>\{\right<C-V>\}<Esc>%a<Space><Space><Esc>i

" greek letter shortcuts for pandoc markdown files
autocmd filetype pandoc imap <C-G>a \alpha
autocmd filetype pandoc imap <C-G>b \beta
autocmd filetype pandoc imap <C-G>s \sigma
autocmd filetype pandoc imap <C-G>g \gamma
autocmd filetype pandoc imap <C-G>m \mu
autocmd filetype pandoc imap <C-G>f \phi
autocmd filetype pandoc imap <C-G>p \pi
autocmd filetype pandoc imap <C-G>w \omega
autocmd filetype pandoc imap <C-G>A \Alpha
autocmd filetype pandoc imap <C-G>B \Beta
autocmd filetype pandoc imap <C-G>S \Sigma
autocmd filetype pandoc imap <C-G>G \Gamma
autocmd filetype pandoc imap <C-G>m \Mu
autocmd filetype pandoc imap <C-G>F \Phi
autocmd filetype pandoc imap <C-G>P \Pi
autocmd filetype pandoc imap <C-G>W \Omega

" }}}

" }}}

" F-Key Mappings {{{

"nmap <F1> K
nmap <silent> <F1> <Plug>DashSearch
nmap <silent> <F12> :syntax sync fromstart<CR>

autocmd filetype pandoc nnoremap <F4> :!pandoc % -o %:r.pdf --pdf-engine=pdflatex<CR>
autocmd filetype pandoc nnoremap <F5> :!pandoc % -o %:r.pdf --pdf-engine=pdflatex --verbose && open %:r.pdf<CR>

nnoremap <leader><F3> :execute ":SlimeSend1 TEST"<CR>
nnoremap <leader><F4> :execute ":SlimeSend1 BUILD"<CR>
nnoremap <leader><F5> :execute ":SlimeSend1 RUN"<CR>

autocmd filetype r nmap <silent> <leader><F1> :!R -e "?<cword>"<CR>
autocmd filetype r nmap <F4> :execute ":SlimeSend1 build r" . bufname("%") . "')"<CR>
autocmd filetype r nmap <F5> :execute ":SlimeSend1 source('" . bufname("%") . "')"<CR>
autocmd filetype r nmap <F6> msvip:SlimeSend<CR>`s
autocmd filetype r vmap <F6> :SlimeSend<CR>gv
autocmd filetype r nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd filetype r nmap <F8> :SlimeSendCurrentLine<CR>

autocmd filetype julia nmap <F3> :execute ":SlimeSend1 julia --color=yes -e \"using Pkg; Pkg.test(\\\"" . systemlist("basename $(git root)")[0] . "\\\")\""<CR>
autocmd filetype julia nmap <F4> :execute ":SlimeSend1 julia -O3 --color=yes " . bufname("%")<CR>
autocmd filetype julia nmap <F5> :execute ":SlimeSend1 include(\"" . bufname("%") . "\")"<CR>
autocmd filetype julia nmap <F6> msvip:SlimeSend<CR>`s
autocmd filetype julia vmap <F6> :SlimeSend<CR>gv
autocmd filetype julia nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd filetype julia nmap <F8> :SlimeSendCurrentLine<CR>

autocmd filetype cpp set keywordprg=cppman
autocmd filetype cpp nmap <silent> <leader><F1> :!cppman <cword><CR>
autocmd filetype cpp nmap <F3> :execute ":SlimeSend1 test cpp"<CR>
autocmd filetype cpp nmap <F4> :execute ":SlimeSend1 build cpp"<CR>
autocmd filetype cpp nmap <F5> :execute ":SlimeSend1 run cpp"<CR>

autocmd filetype shell nmap <silent> <leader><F1> :!man <cword><CR>
autocmd filetype shell nmap <F4> :execute ":SlimeSend1 ./" . bufname("%") . ""<CR>
autocmd filetype shell nmap <F5> :execute ":SlimeSend1 . " . bufname("%") . ""<CR>
autocmd filetype shell nmap <F6> msvip:SlimeSend<CR>`s
autocmd filetype shell vmap <F6> :SlimeSend<CR>gv
autocmd filetype shell nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd filetype shell nmap <F8> :SlimeSendCurrentLine<CR>

autocmd filetype sql nmap <silent> <leader><F1> :!psql postgres -c "\\h <cword>"<CR>
autocmd filetype sql nmap <F4> :execute ":SlimeSend1 sql -f " . bufname("%") . ""<CR>
autocmd filetype sql nmap <F5> :execute ":SlimeSend1 \\i " . bufname("%") . ""<CR>
autocmd filetype sql nmap <F6> msvip:SlimeSend<CR>`s
autocmd filetype sql vmap <F6> :SlimeSend<CR>gv
autocmd filetype sql nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd filetype sql nmap <F8> :SlimeSendCurrentLine<CR>

autocmd filetype python nmap <silent> <leader><F1> :!ipython -c "?<cword>"<CR>
autocmd filetype python nmap <F3> :execute ":SlimeSend1 test python"<CR>
autocmd filetype python nmap <F4> :execute ":SlimeSend1 build python"<CR>
autocmd filetype python nmap <F5> :execute ":SlimeSend1 exec(open('" . bufname("%") . "').read())"<CR>
autocmd filetype python nmap <F6> msvip:SlimeSend<CR>`s
autocmd filetype python vmap <F6> :SlimeSend<CR>gv
autocmd filetype python nmap <F7> :SlimeSendCurrentLine<CR>j
autocmd filetype python nmap <F8> :SlimeSendCurrentLine<CR>

autocmd filetype go nmap <F5> :execute ":SlimeSend1 go run " . bufname("%")<CR>

" }}}

" }}}

" Language Preferences {{{

" lzz files interpreted as cpp files
autocmd BufNewFile,BufRead *.lzz set filetype=cpp

" treat yaml files uniquely with regards to indenting
autocmd! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" detect ansible files
autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=ansible
autocmd BufRead,BufNewFile */site.yml set filetype=ansible
autocmd BufRead,BufNewFile */main.yml set filetype=ansible
autocmd BufRead,BufNewFile */ansible/*.yml set filetype=ansible

" }}}

" }}}

" Make vim use triple bracket fold markers in vimrc
" vim:foldmethod=marker
