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

if !empty(glob("~/.vim/colors/jamos.vim"))
    colorscheme jamos                                              " custom colorscheme
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
set backspace=indent,eol,start                  " make backspace work like most apps
" language-specific whitespace settings
autocmd filetype r setlocal tabstop=2
autocmd filetype r setlocal softtabstop=2
autocmd filetype r setlocal shiftwidth=2
"autocmd filetype vue setlocal tabstop=2
"autocmd filetype vue setlocal softtabstop=2
"autocmd filetype vue setlocal shiftwidth=2
autocmd filetype fortran setlocal shiftwidth=3
autocmd filetype fortran setlocal tabstop=3
autocmd filetype fortran setlocal softtabstop=3

" }}}

" }}}

" Functional Tweaks {{{

" General {{{

set diffopt+=iwhite            " split diffs horizontally (top/bottom) and ignore whitespace
set updatetime=125             " increase responsiveness for event triggering
set mouse=a                    " enable use of scrolling with the mouse
set noswapfile                 " dont create temporary swap files
set hidden                     " retain undo history when changing buffers
set autoindent                 " keep indent from current line when starting new line
set smartindent                " make indenting logic smarter using language syntax
set ruler                      " always show the current cursor position
set incsearch                  " make search act like in modern web browsers
set autoread                   " automatically read when a file is changed externally
set regexpengine=1             " newer regular expression engine (versions 7.4+)
autocmd VimResized * :wincmd = " automatically resize scale windows when terminal is resized
if has("clipboard")
    set clipboard=unnamed      " copy to system clipboard
endif

" set timeout timeoutlen=500 ttimeoutlen=100 " reduce lag/delay when switching between modes

" change cursor shape dynamically (see https://stackoverflow.com/a/30199177/2271756)
if exists('$TMUX')
  let &t_SI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=1\x7\<esc>\\"
  let &t_EI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=0\x7\<esc>\\"
else
  let &t_SI = "\<esc>]50;CursorShape=1\x7"
  let &t_EI = "\<esc>]50;CursorShape=0\x7"
endif
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" }}}

" Folding {{{

set foldenable                                " enable code folding
set foldmethod=indent                         " fold based on language syntax
set foldlevelstart=99                         " fold level at file open (0=everything folded, 99=nothing)
set foldnestmax=99                            " maximum fold nesting
set modelines=1                               " check last line of file for a modeline so vimrc can be folded
autocmd filetype python set foldmethod=indent " overwrite pymode indent method

" }}}

" Formatters {{{

" format current file
nmap <leader>fmt m0gggqG`0zz

" language-specific formatting programs
autocmd filetype c setlocal formatprg=clang-format\ -style=file\ -
autocmd filetype cpp setlocal formatprg=clang-format\ -style=file\ -
autocmd filetype rust setlocal formatprg=rustfmt\ --edition\ 2021
autocmd filetype css setlocal formatprg=prettier\ --parser\ css\ --print-width\ 120\ --tab-width\ 4
autocmd filetype fortran setlocal formatprg=fprettify\ --silent\ -
autocmd filetype html setlocal formatprg=tidy\ -config\ $HOME/.tidyrc
autocmd filetype javascript,vue setlocal formatprg=prettier\ --parser\ vue\ --print-width\ 120\ --tab-width\ 4\ --no-bracket-spacing\ --prose-wrap\ preserve\ --trailing-comma\ all
autocmd filetype javascript,vue setlocal indentexpr=GetJavascriptIndent()
autocmd filetype python setlocal formatprg=black\ --line-length\ 125\ --quiet\ -\ 2>/dev/null
autocmd filetype r setlocal formatprg=python\ $R_LIBS_USER/rfmt/python/rfmt.py\ \--margin1\ 120\ --indent\ 2\ --space_arg_eq\ False
autocmd filetype sql setlocal formatprg=pg_format\ -
autocmd filetype bash,zsh,shell setlocal formatprg=shfmt\ -i\ 4

" format keymap overrides
autocmd filetype css nmap <leader>fmt :!prettier --write --parser css %<CR><CR>
autocmd filetype go nmap <leader>fmt :GoFmt<CR>
autocmd filetype html nmap <leader>fmt :!tidy -config ~/.tidyrc %<CR><CR>
autocmd filetype tpl nmap <leader>fmt :!tidy -config ~/.tidyrc %<CR><CR>

" }}

" }}}

" Language-Specific {{{

" lzz files interpreted as cpp files
autocmd BufNewFile,BufRead *.lzz set filetype=cpp
autocmd BufNewFile,BufRead *.scss set filetype=sass

" treat yaml files uniquely with regards to indenting
autocmd! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" detect ansible files
autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=ansible
autocmd BufRead,BufNewFile */site.yml set filetype=ansible
autocmd BufRead,BufNewFile */main.yml set filetype=ansible
autocmd BufRead,BufNewFile */ansible/*.yml set filetype=ansible

" Nested Language Definitions {{{

" NOTE: copied from https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
" EXAMPLES:
" call TextEnableCodeSnip(  'c',   '@begin=c@',   '@end=c@', 'SpecialComment')
" call TextEnableCodeSnip('cpp', '@begin=cpp@', '@end=cpp@', 'SpecialComment')
" call TextEnableCodeSnip('sql', '@begin=sql@', '@end=sql@', 'SpecialComment')
" call TextEnableCodeSnip('html' ,'#{{{html' ,'#html}}}', 'SpecialComment')

function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
    let ft=toupper(a:filetype)
    let group='textGroup'.ft
    if exists('b:current_syntax')
        let s:current_syntax=b:current_syntax
        " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
        " do nothing if b:current_syntax is defined.
        unlet b:current_syntax
    endif
    execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
    try
        execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
    catch
    endtry
    if exists('s:current_syntax')
        let b:current_syntax=s:current_syntax
    else
        unlet b:current_syntax
    endif
    execute 'syntax region textSnip'.ft.'
                \ matchgroup='.a:textSnipHl.'
                \ keepend
                \ start="'.a:start.'" end="'.a:end.'"
                \ contains=@'.group
endfunction

" }}}

" }}}

" }}}

" Keymap Tweaks {{{

" General Mappings {{{

" refactoring / variable replacement
" local (scope) refactor
nmap gr gd[{V%::s/<C-R>///gc<Left><Left><Left>
autocmd filetype python nmap gr gdViM::s/<C-R>///gc<Left><Left><Left>
" global refactor
nmap gR gDVG::s/<C-R>///gc<Left><Left><Left>

" Global variable replacement
"nnoremap gR gD::%s/<C-R>///gc<left><left><left>

" yank/copy from cursor to end of line
nnoremap Y y$

" shortcut to replace word by pasting before it, deleting it, and adding a space
nnoremap R Pldwi<esc>bye

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

" search word under cursor without moving location
nnoremap <leader>// *N
" fast case-insenstive search
nnoremap <C-F> /\c<left><left>

" fast pane splitting and focus switching
nnoremap <expr><silent> \| !v:count ? "<C-W>v<C-W><Right>" : '\|'
nnoremap <expr><silent> _ !v:count ? "<C-W>s<C-W><Down>"  : '_'
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W

" ctrl+h to turn off highlighting
nnoremap <esc><esc> :nohl<CR>

" easy align initializer keymap
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }}}

" Leader Mappings {{{

" location list opening/closing/navigation
nmap <leader>lc :lclose<CR>
nmap <leader>lo :lopen<CR>
nmap <leader>ln :lnext<CR>
nmap <leader>lp :lprevious<CR>
nmap <leader>ll :llast<CR>
nmap <leader>lf :lfirst<CR>

" cpp header/source switching
autocmd filetype cpp nmap <leader>hdr :e %:r.h<cr>
autocmd filetype cpp nmap <leader>src :e %:r.cpp<cr>

" debuggers
autocmd filetype python nmap <leader>db oimport ipdb; ipdb.set_trace()<esc>

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

" quick isolation of the currently focused file
nnoremap <leader><esc><esc> :only<CR>

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
nmap <leader>zzx :g/#\(hdr\\|src\\|end\)/s/^/\/\//<CR>:nohl<CR>``
nmap <leader>zza :g/#\(hdr\\|src\\|end\)/s/^\/\//<CR>:nohl<CR>``
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
nnoremap <C-K> :bwipeout<CR>

" ctrl+t to access terminal
nnoremap <C-T> :shell<CR>

" ctrl+s to save
nnoremap <C-S> :w<CR>
inoremap <C-S> <esc>:w<CR>a

" ctrl+e to refresh file
nnoremap <C-E> :e<CR>

" ctrl+q to quit
nnoremap <C-Q> :q<CR>


" }}}

" Insert Mode {{{

" quickly save while in insert mode
inoremap <silent> <C-S> <esc>:w<CR>a

" latex symbol shortcuts for pandoc markdown files
autocmd filetype pandoc vmap <C-J> <esc>f{vi{
autocmd filetype pandoc imap <C-J> <esc>f{vi{
autocmd filetype pandoc nmap <C-J> <esc>f{vi{
autocmd filetype pandoc imap <C-L> _{}<esc>i
autocmd filetype pandoc imap <C-E> ^{}<esc>i
autocmd Filetype pandoc imap <C-F> \text{}<esc>i
autocmd filetype pandoc imap <C-T>s \sum\limits_{i=1}^{N}<esc>F=vi{
autocmd filetype pandoc imap <C-T>p \prod\limits_{i=1}^{N}<esc>F=vi{
autocmd filetype pandoc imap <C-T>f \frac{1}{N}<esc>F1v
autocmd filetype pandoc imap <C-T>tf \tfrac{1}{N}<esc>F1v
autocmd filetype pandoc imap <C-B> \left<C-V>[\right<C-V>]<esc>%a<Space><Space><esc>i
autocmd filetype pandoc imap <C-P> \left<C-V>(\right<C-V>)<esc>%a<Space><Space><esc>i
autocmd filetype pandoc imap <C-C> \left<C-V>\{\right<C-V>\}<esc>%a<Space><Space><esc>i

" greek letter shortcuts for pandoc markdown files
autocmd filetype pandoc imap <C-G>a \alpha
autocmd filetype pandoc imap <C-G>b \beta
autocmd filetype pandoc imap <C-G>c \gamma
autocmd filetype pandoc imap <C-G>d \delta
autocmd filetype pandoc imap <C-G>f \phi
autocmd filetype pandoc imap <C-G>g \gamma
autocmd filetype pandoc imap <C-G>l \lambda
autocmd filetype pandoc imap <C-G>m \mu
autocmd filetype pandoc imap <C-G>p \pi
autocmd filetype pandoc imap <C-G>s \sigma
autocmd filetype pandoc imap <C-G>w \omega
autocmd filetype pandoc imap <C-G>A \Alpha
autocmd filetype pandoc imap <C-G>B \Beta
autocmd filetype pandoc imap <C-G>C \Gamma
autocmd filetype pandoc imap <C-G>D \Delta
autocmd filetype pandoc imap <C-G>F \Phi
autocmd filetype pandoc imap <C-G>G \Gamma
autocmd filetype pandoc imap <C-G>L \Lambda
autocmd filetype pandoc imap <C-G>M \Mu
autocmd filetype pandoc imap <C-G>P \Pi
autocmd filetype pandoc imap <C-G>S \Sigma
autocmd filetype pandoc imap <C-G>W \Omega

" }}}

" }}}

" F-Key Mappings {{{

"nmap <F1> K
nmap <silent> <F1> <Plug>DashSearch
autocmd BufEnter * :syntax sync fromstart
nmap <silent> <F12> :syntax sync fromstart<CR>

autocmd filetype pandoc nmap <F4> :!pandoc % -o %:r.pdf --metadata date="`date '+\%B \%e, \%Y'`" --pdf-engine=pdflatex --filter pandoc-eqnos<CR>
autocmd filetype pandoc nmap <F5> :!pandoc % -o %:r.pdf --metadata date="`date '+\%B \%e, \%Y'`" --pdf-engine=pdflatex --verbose --filter pandoc-eqnos && open %:r.pdf<CR>

nnoremap <leader><F3> :execute ":SlimeSend1 TEST"<CR>
nnoremap <leader><F4> :execute ":SlimeSend1 BUILD"<CR>
nnoremap <leader><F5> :execute ":SlimeSend1 RUN"<CR>
nmap <F6> msvip:SlimeSend<CR>`s
vmap <F6> <C-C><C-C>gv
nmap <F7> :SlimeSendCurrentLine<CR>j
nmap <F8> :SlimeSendCurrentLine<CR>
imap <F7> <esc>:SlimeSendCurrentLine<CR>o
imap <F8> <esc><F8>a
nmap <F9> ggV``<F6>V

autocmd filetype r nmap <silent> <leader><F1> :!R -e "?<cword>"<CR>
autocmd filetype r nmap <F4> :execute ":SlimeSend1 build r" . bufname("%") . "')"<CR>
autocmd filetype r nmap <F5> :execute ":SlimeSend1 source('" . bufname("%") . "')"<CR>

autocmd filetype julia nmap <F3> :execute ":SlimeSend1 julia --color=yes -e \"using Pkg; Pkg.test(\\\"" . systemlist("basename $(git root)")[0] . "\\\")\""<CR>
autocmd filetype julia nmap <F4> :execute ":SlimeSend1 julia -O3 --color=yes " . bufname("%")<CR>
autocmd filetype julia nmap <F5> :execute ":SlimeSend1 include(\"" . bufname("%") . "\")"<CR>

autocmd filetype cpp set keywordprg=cppman
autocmd filetype cpp nmap <silent> <leader><F1> :!cppman <cword><CR>
autocmd filetype cpp nmap <F3> :execute ":SlimeSend1 test cpp"<CR>
autocmd filetype cpp nmap <F4> :execute ":SlimeSend1 build cpp"<CR>
autocmd filetype cpp nmap <F5> :execute ":SlimeSend1 run cpp"<CR>

autocmd filetype shell nmap <silent> <leader><F1> :!man <cword><CR>
autocmd filetype shell nmap <F4> :execute ":SlimeSend1 ./" . bufname("%") . ""<CR>
autocmd filetype shell nmap <F5> :execute ":SlimeSend1 source " . bufname("%") . ""<CR>

autocmd filetype sql nmap <silent> <leader><F1> :!psql postgres -c "\\h <cword>"<CR>
autocmd filetype sql nmap <F4> :execute ":SlimeSend1 sql -f " . bufname("%") . ""<CR>
autocmd filetype sql nmap <F5> :execute ":SlimeSend1 \\i " . bufname("%") . ""<CR>

autocmd filetype python nmap <silent> <leader><F1> :!ipython -c "?<cword>"<CR>
autocmd filetype python nmap <F3> :execute ":SlimeSend1 test python"<CR>
autocmd filetype python nmap <F4> :execute ":SlimeSend1 from " . substitute(expand('%:r'), "/", ".", "g") . " import *"<CR>
autocmd filetype python nmap <leader><F5> :execute ":SlimeSend1 exec(open('" . bufname("%") . "').read())"<CR>
autocmd filetype python nmap <F5> :execute ":SlimeSend1 %run " . bufname("%") ""<CR>

autocmd filetype go nmap <F5> :execute ":SlimeSend1 go run " . bufname("%")<CR>

" }}}

" }}}

" Make vim use triple bracket fold markers in vimrc
" vim:foldmethod=marker
