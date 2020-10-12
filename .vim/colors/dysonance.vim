set cursorline

""==================
"" Color Reference
""==================
" Name    Dark Light
" Black   0    8
" Red     1    9
" Green   2    10
" Yellow  3    11
" Blue    4    12
" Magenta 5    13
" Cyan    6    14
" White   7    15
""==================

if has('nvim')

    highlight ActiveWindow ctermfg=none
    highlight InactiveWindow ctermfg=7 ctermbg=8
    " call method on window enter
    augroup WindowManagement
        autocmd!
        autocmd WinEnter * call DimInactive()
    augroup END
    " change highlight group of active/inactive windows
    function! DimInactive()
        setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow,StatusLine:ActiveWindow,StatusLineNC:InactiveWindow
    endfunction

    set termguicolors
    " general highlighting
    highlight Normal       ctermfg=none ctermbg=none cterm=none           guifg=none    guibg=none    gui=none
    highlight Cursor       ctermfg=none ctermbg=none cterm=none           guifg=none    guibg=none    gui=none
    highlight CursorLine   ctermfg=none ctermbg=4    cterm=none           guifg=none    guibg=#000080 gui=none
    highlight CursorLineNR ctermfg=none ctermbg=12   cterm=none           guifg=none    guibg=#0000ff gui=none
    highlight Function     ctermfg=11   ctermbg=none cterm=none           guifg=#ffff00 guibg=none    gui=none
    highlight Identifier   ctermfg=none ctermbg=none cterm=none           guifg=none    guibg=none    gui=none
    " constant highlighting group
    highlight Boolean      ctermfg=9    ctermbg=none cterm=none           guifg=#ff0000 guibg=none    gui=none
    highlight Character    ctermfg=10   ctermbg=none cterm=none           guifg=#00ff00 guibg=none    gui=none
    highlight Constant     ctermfg=1    ctermbg=none cterm=none           guifg=#800000 guibg=none    gui=none
    highlight Float        ctermfg=9    ctermbg=none cterm=none           guifg=#ff0000 guibg=none    gui=none
    highlight Number       ctermfg=9    ctermbg=none cterm=none           guifg=#ff0000 guibg=none    gui=none
    highlight String       ctermfg=10   ctermbg=none cterm=none           guifg=#00ff00 guibg=none    gui=none
    " statement highlighting group
    highlight Conditional  ctermfg=13   ctermbg=none cterm=none           guifg=#ff00ff guibg=none    gui=none
    highlight Keyword      ctermfg=5    ctermbg=none cterm=none           guifg=#800080 guibg=none    gui=none
    highlight Operator     ctermfg=11   ctermbg=none cterm=none           guifg=#ffff00 guibg=none    gui=none
    highlight PreProc      ctermfg=3    ctermbg=none cterm=none           guifg=#804000 guibg=none    gui=none
    highlight Repeat       ctermfg=13   ctermbg=none cterm=none           guifg=#ff00ff guibg=none    gui=none
    highlight Statement    ctermfg=13   ctermbg=none cterm=none           guifg=#ff00ff guibg=none    gui=none
    " special highlighting group
    highlight Comment      ctermfg=12   ctermbg=7    cterm=none           guifg=#0000ff guibg=#808080 gui=none
    highlight Delimiter    ctermfg=14   ctermbg=none cterm=none           guifg=#00ffff guibg=none    gui=none
    highlight Special      ctermfg=3    ctermbg=none cterm=none           guifg=#808000 guibg=none    gui=none
    highlight SpecialChar  ctermfg=2    ctermbg=none cterm=none           guifg=#804000 guibg=none    gui=none
    highlight Tag          ctermfg=13   ctermbg=none cterm=none           guifg=#ff00ff guibg=none    gui=none
    highlight Todo         ctermfg=11   ctermbg=4    cterm=bold           guifg=#ffff00 guibg=#000080 gui=bold
    highlight Type         ctermfg=208  ctermbg=none cterm=none           guifg=#ff8000 guibg=none    gui=none
    " other random highlights
    highlight IncSearch    ctermfg=none ctermbg=2    cterm=bold           guifg=none    guibg=#008000 gui=bold
    highlight LineNR       ctermfg=7    ctermbg=none cterm=none           guifg=#808080 guibg=none    gui=none
    highlight MatchParen   ctermfg=none ctermbg=2    cterm=none           guifg=none    guibg=#008000 gui=none
    highlight Pmenu        ctermfg=7    ctermbg=4    cterm=none           guifg=#808080 guibg=4       gui=none
    highlight PmenuSel     ctermfg=none ctermbg=8    cterm=none           guifg=none    guibg=8       gui=none
    highlight Search       ctermfg=none ctermbg=2    cterm=bold           guifg=none    guibg=#008000 gui=bold
    highlight StatusLine   ctermfg=12   ctermbg=14   cterm=none           guifg=#0000ff guibg=#00ffff gui=none
    highlight Visual       ctermfg=none ctermbg=7    cterm=none           guifg=none    guibg=#808080 gui=none
    " errors and warnings highlighting
    highlight Error        ctermfg=none ctermbg=1    cterm=none           guifg=none    guibg=#800000 gui=none
    highlight ErrorMsg     ctermfg=none ctermbg=1    cterm=none           guifg=none    guibg=#800000 gui=none
    highlight WarningMsg   ctermfg=none ctermbg=1    cterm=none           guifg=none    guibg=#800000 gui=none
    " diff highlights
    highlight DiffAdd      ctermfg=none ctermbg=2    cterm=bold           guifg=none    guibg=#008000 gui=bold
    highlight DiffChange   ctermfg=none ctermbg=none cterm=bold           guifg=none    guibg=none    gui=bold
    highlight DiffDelete   ctermfg=9    ctermbg=1    cterm=bold           guifg=#ff0000 guibg=#800000 gui=bold
    highlight DiffText     ctermfg=none ctermbg=3    cterm=bold,underline guifg=none    guibg=#808000 gui=bold,underline

    " plugin-specific
    highlight GitGutterAdd          ctermfg=2 guifg=#008000
    highlight GitGutterChange       ctermfg=3 guifg=#808000
    highlight GitGutterDelete       ctermfg=1 guifg=#800000
    highlight GitGutterChangeDelete ctermfg=4 guifg=#808000

else

    set notermguicolors
    " general highlighting
    highlight Normal       ctermfg=none ctermbg=none cterm=none
    highlight Cursor       ctermfg=none ctermbg=none cterm=none
    highlight CursorLine   ctermfg=none ctermbg=4    cterm=none
    highlight CursorLineNR ctermfg=none ctermbg=12   cterm=none
    highlight Function     ctermfg=11   ctermbg=none cterm=none
    highlight Identifier   ctermfg=none ctermbg=none cterm=none
    " constant highlighting group
    highlight Boolean      ctermfg=9    ctermbg=none cterm=none
    highlight Character    ctermfg=10   ctermbg=none cterm=none
    highlight Constant     ctermfg=1    ctermbg=none cterm=none
    highlight Float        ctermfg=9    ctermbg=none cterm=none
    highlight Number       ctermfg=9    ctermbg=none cterm=none
    highlight String       ctermfg=10   ctermbg=none cterm=none
    " statement highlighting group
    highlight Conditional  ctermfg=13   ctermbg=none cterm=none
    highlight Keyword      ctermfg=5    ctermbg=none cterm=none
    highlight Operator     ctermfg=11   ctermbg=none cterm=none
    highlight PreProc      ctermfg=3    ctermbg=none cterm=none
    highlight Repeat       ctermfg=13   ctermbg=none cterm=none
    highlight Statement    ctermfg=13   ctermbg=none cterm=none
    " special highlighting group
    highlight Comment      ctermfg=12   ctermbg=7    cterm=none
    highlight Delimiter    ctermfg=14   ctermbg=none cterm=none
    highlight Special      ctermfg=3    ctermbg=none cterm=none
    highlight SpecialChar  ctermfg=2    ctermbg=none cterm=none
    highlight Tag          ctermfg=13   ctermbg=none cterm=none
    highlight Todo         ctermfg=11   ctermbg=4    cterm=bold
    highlight Type         ctermfg=208  ctermbg=none cterm=none
    " other random highlights
    highlight IncSearch    ctermfg=none ctermbg=2    cterm=bold
    highlight LineNR       ctermfg=7    ctermbg=none cterm=none
    highlight MatchParen   ctermfg=none ctermbg=2    cterm=none
    highlight Pmenu        ctermfg=7    ctermbg=4    cterm=none
    highlight PmenuSel     ctermfg=none ctermbg=8    cterm=none
    highlight Search       ctermfg=none ctermbg=2    cterm=bold
    highlight StatusLine   ctermfg=12   ctermbg=14   cterm=none
    highlight Visual       ctermfg=none ctermbg=7    cterm=none
    " errors and warnings highlighting
    highlight Error        ctermfg=none ctermbg=1    cterm=none
    highlight ErrorMsg     ctermfg=none ctermbg=1    cterm=none
    highlight WarningMsg   ctermfg=none ctermbg=1    cterm=none
    " diff highlights
    highlight DiffAdd      ctermfg=none ctermbg=2    cterm=bold
    highlight DiffChange   ctermfg=none ctermbg=none cterm=bold
    highlight DiffDelete   ctermfg=9    ctermbg=1    cterm=bold
    highlight DiffText     ctermfg=none ctermbg=3    cterm=bold,underline
    " plugin-specific
    highlight GitGutterAdd          ctermfg=2
    highlight GitGutterChange       ctermfg=3
    highlight GitGutterDelete       ctermfg=1
    highlight GitGutterChangeDelete ctermfg=4

endif
