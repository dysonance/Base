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

" general highlighting
highlight Normal                ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=NONE    guibg=NONE    gui=NONE
highlight NormalNC              ctermfg=7    ctermbg=NONE guifg=NONE           guifg=NONE    guibg=#404040 gui=NONE
highlight Cursor                ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=NONE    guibg=NONE    gui=NONE
highlight CursorLine            ctermfg=NONE ctermbg=4    cterm=NONE           guifg=NONE    guibg=#000040 gui=NONE
highlight CursorLineNR          ctermfg=NONE ctermbg=12   cterm=NONE           guifg=NONE    guibg=#0000ff gui=NONE
highlight Identifier            ctermfg=NONE ctermbg=NONE cterm=NONE           guifg=NONE    guibg=NONE    gui=NONE
" constant highlighting group
highlight Boolean               ctermfg=9    ctermbg=NONE cterm=NONE           guifg=#ff0000 guibg=NONE    gui=NONE
highlight Character             ctermfg=10   ctermbg=NONE cterm=NONE           guifg=#00ff00 guibg=NONE    gui=NONE
highlight Constant              ctermfg=1    ctermbg=NONE cterm=NONE           guifg=#800000 guibg=NONE    gui=NONE
highlight Float                 ctermfg=9    ctermbg=NONE cterm=NONE           guifg=#ff0000 guibg=NONE    gui=NONE
highlight Number                ctermfg=9    ctermbg=NONE cterm=NONE           guifg=#ff0000 guibg=NONE    gui=NONE
highlight String                ctermfg=10   ctermbg=NONE cterm=NONE           guifg=#00ff00 guibg=NONE    gui=NONE
" statement highlighting group
highlight Conditional           ctermfg=13   ctermbg=NONE cterm=NONE           guifg=#ff00ff guibg=NONE    gui=NONE
highlight Keyword               ctermfg=5    ctermbg=NONE cterm=NONE           guifg=#800080 guibg=NONE    gui=NONE
highlight Operator              ctermfg=11   ctermbg=NONE cterm=NONE           guifg=#ffff00 guibg=NONE    gui=NONE
highlight PreProc               ctermfg=3    ctermbg=NONE cterm=NONE           guifg=#804000 guibg=NONE    gui=NONE
highlight Repeat                ctermfg=13   ctermbg=NONE cterm=NONE           guifg=#ff00ff guibg=NONE    gui=NONE
highlight Statement             ctermfg=13   ctermbg=NONE cterm=NONE           guifg=#ff00ff guibg=NONE    gui=NONE
" special highlighting group
highlight Comment               ctermfg=7    ctermbg=NONE cterm=NONE           guifg=#808080 guibg=NONE    gui=NONE
highlight Delimiter             ctermfg=14   ctermbg=NONE cterm=NONE           guifg=#00ffff guibg=NONE    gui=NONE
highlight Function              ctermfg=11   ctermbg=NONE cterm=NONE           guifg=#ffff00 guibg=NONE    gui=NONE
highlight Special               ctermfg=3    ctermbg=NONE cterm=NONE           guifg=#808000 guibg=NONE    gui=NONE
highlight SpecialChar           ctermfg=2    ctermbg=NONE cterm=NONE           guifg=#804000 guibg=NONE    gui=NONE
highlight Tag                   ctermfg=13   ctermbg=NONE cterm=NONE           guifg=#ff00ff guibg=NONE    gui=NONE
highlight Todo                  ctermfg=11   ctermbg=4    cterm=bold           guifg=#ffff00 guibg=#000080 gui=bold
highlight Type                  ctermfg=6    ctermbg=NONE cterm=NONE           guifg=#ff8000 guibg=NONE    gui=NONE
" other random highlights
highlight IncSearch             ctermfg=NONE ctermbg=2    cterm=bold           guifg=NONE    guibg=#008000 gui=bold
highlight LineNR                ctermfg=7    ctermbg=NONE cterm=NONE           guifg=#808080 guibg=NONE    gui=NONE
highlight MatchParen            ctermfg=NONE ctermbg=2    cterm=NONE           guifg=NONE    guibg=#008000 gui=NONE
highlight Pmenu                 ctermfg=7    ctermbg=4    cterm=NONE           guifg=#808080 guibg=#000080 gui=NONE
highlight PmenuSel              ctermfg=NONE ctermbg=8    cterm=NONE           guifg=NONE    guibg=#0000ff gui=NONE
highlight Search                ctermfg=NONE ctermbg=2    cterm=bold           guifg=NONE    guibg=#008000 gui=bold
highlight StatusLine            ctermfg=12   ctermbg=14   cterm=NONE           guifg=#0000ff guibg=#00ffff gui=NONE
highlight Visual                ctermfg=NONE ctermbg=7    cterm=NONE           guifg=NONE    guibg=#808080 gui=NONE
" errors and warnings highlighting
highlight Error                 ctermfg=NONE ctermbg=1    cterm=NONE           guifg=NONE    guibg=#800000 gui=NONE
highlight ErrorMsg              ctermfg=NONE ctermbg=1    cterm=NONE           guifg=NONE    guibg=#800000 gui=NONE
highlight WarningMsg            ctermfg=NONE ctermbg=1    cterm=NONE           guifg=NONE    guibg=#800000 gui=NONE
" diff highlights
highlight DiffAdd               ctermfg=NONE ctermbg=2    cterm=bold           guifg=NONE    guibg=#004000 gui=bold
highlight DiffChange            ctermfg=NONE ctermbg=12   cterm=bold           guifg=NONE    guibg=#000080 gui=bold
highlight DiffDelete            ctermfg=9    ctermbg=1    cterm=bold           guifg=#400000 guibg=#400000 gui=bold
highlight DiffText              ctermfg=NONE ctermbg=3    cterm=bold,underline guifg=NONE    guibg=#404000 gui=bold,underline
" plugin-specific
highlight GitGutterAdd          ctermfg=2    ctermbg=NONE cterm=NONE           guifg=#008000 guibg=NONE    gui=NONE
highlight GitGutterChange       ctermfg=3    ctermbg=NONE cterm=NONE           guifg=#808000 guibg=NONE    gui=NONE
highlight GitGutterDelete       ctermfg=1    ctermbg=NONE cterm=NONE           guifg=#800000 guibg=NONE    gui=NONE
highlight GitGutterChangeDelete ctermfg=4    ctermbg=NONE cterm=NONE           guifg=#808000 guibg=NONE    gui=NONE
