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

" General highlighting
highlight Normal       ctermfg=15   ctermbg=4    cterm=none
highlight Cursor       ctermfg=none ctermbg=none cterm=none
highlight CursorLine   ctermfg=none ctermbg=0    cterm=none
highlight CursorLineNR ctermfg=15   ctermbg=12   cterm=none
highlight Function     ctermfg=11   ctermbg=none cterm=none
highlight Identifier   ctermfg=15   ctermbg=none cterm=none
" Constant highlighting group
highlight Boolean      ctermfg=9    ctermbg=none cterm=none
highlight Character    ctermfg=10   ctermbg=none cterm=none
highlight Constant     ctermfg=1    ctermbg=none cterm=none
highlight Float        ctermfg=9    ctermbg=none cterm=none
highlight Number       ctermfg=9    ctermbg=none cterm=none
highlight String       ctermfg=10   ctermbg=none cterm=none
" Statement highlighting group
highlight Conditional  ctermfg=13   ctermbg=none cterm=none
highlight Keyword      ctermfg=6    ctermbg=none cterm=none
highlight Operator     ctermfg=11   ctermbg=none cterm=none
highlight PreProc      ctermfg=3    ctermbg=none cterm=none
highlight Repeat       ctermfg=13   ctermbg=none cterm=none
highlight Statement    ctermfg=13   ctermbg=none cterm=none
" Special highlighting group
highlight Comment      ctermfg=8    ctermbg=none cterm=none
highlight Delimiter    ctermfg=14   ctermbg=none cterm=none
highlight Special      ctermfg=3    ctermbg=none cterm=none
highlight SpecialChar  ctermfg=2    ctermbg=none cterm=none
highlight Tag          ctermfg=13   ctermbg=none cterm=none
highlight Todo         ctermfg=11   ctermbg=12   cterm=bold
highlight Type         ctermfg=208  ctermbg=none cterm=none
" Other random highlights
highlight IncSearch    ctermfg=none ctermbg=2    cterm=bold
highlight LineNR       ctermfg=8    ctermbg=none cterm=none
highlight MatchParen   ctermfg=none ctermbg=12   cterm=none
highlight Pmenu        ctermfg=7    ctermbg=0    cterm=none
highlight PmenuSel     ctermfg=15   ctermbg=3    cterm=none
highlight Search       ctermfg=none ctermbg=2    cterm=bold
highlight StatusLine   ctermfg=12   ctermbg=14   cterm=none
highlight Visual       ctermfg=none ctermbg=8    cterm=none
" Errors and warnings highlighting
highlight Error        ctermfg=none ctermbg=1    cterm=none
highlight ErrorMsg     ctermfg=none ctermbg=1    cterm=none
highlight WarningMsg   ctermfg=none ctermbg=0    cterm=none
" Diff highlights
highlight DiffAdd      ctermfg=10   ctermbg=2    cterm=none
highlight DiffChange   ctermfg=none ctermbg=none cterm=none
highlight DiffDelete   ctermfg=9    ctermbg=1    cterm=none
highlight DiffText     ctermfg=11   ctermbg=3    cterm=bold,underline
