set t_Co=256

" General highlighting
highlight Normal     ctermfg=White  ctermbg=Black cterm=NONE
highlight Comment    ctermfg=Blue   ctermbg=NONE  cterm=NONE
highlight Identifier ctermfg=White  ctermbg=NONE  cterm=NONE
highlight Function   ctermfg=Yellow ctermbg=NONE  cterm=NONE

" Constant highlighting group
highlight Constant  ctermfg=DarkRed ctermbg=NONE cterm=NONE
highlight Number    ctermfg=Red     ctermbg=NONE cterm=NONE
highlight Float     ctermfg=Red     ctermbg=NONE cterm=NONE
highlight Boolean   ctermfg=Red     ctermbg=NONE cterm=NONE
highlight String    ctermfg=Green   ctermbg=NONE cterm=NONE
highlight Character ctermfg=Green   ctermbg=NONE cterm=NONE

" Statement highlighting group
highlight Statement   ctermfg=Cyan       ctermbg=NONE cterm=NONE
highlight Conditional ctermfg=Magenta    ctermbg=NONE cterm=NONE
highlight Repeat      ctermfg=Magenta    ctermbg=NONE cterm=NONE
highlight Operator    ctermfg=Yellow     ctermbg=NONE cterm=NONE
highlight Keyword     ctermfg=Magenta    ctermbg=NONE cterm=NONE
highlight PreProc     ctermfg=DarkYellow ctermbg=NONE cterm=NONE

" Special highlighting group
" NOTE: 208 is orange, 3 is gold
highlight Type        ctermfg=208        ctermbg=NONE  cterm=NONE
highlight Special     ctermfg=3          ctermbg=NONE  cterm=NONE
highlight Delimiter   ctermfg=Cyan       ctermbg=NONE  cterm=NONE
highlight Tag         ctermfg=Magenta    ctermbg=NONE  cterm=NONE
highlight SpecialChar ctermfg=DarkYellow ctermbg=NONE  cterm=NONE
highlight Todo        ctermfg=Yellow     ctermbg=Black cterm=NONE

" Other random highlights
set cursorline
highlight StatusLine   ctermfg=Blue  ctermbg=Grey     cterm=NONE
highlight CursorLine   ctermfg=NONE  ctermbg=DarkBlue cterm=NONE
highlight CursorLineNR ctermfg=White ctermbg=Blue     cterm=NONE
highlight LineNR       ctermfg=Grey  ctermbg=NONE     cterm=NONE
highlight Pmenu        ctermfg=Black ctermbg=Cyan     cterm=NONE
highlight PmenuSel     ctermfg=White ctermbg=DarkCyan cterm=NONE
highlight Visual       ctermfg=NONE  ctermbg=DarkGrey cterm=NONE
highlight IncSearch    ctermfg=NONE  ctermbg=DarkGrey cterm=NONE
highlight Search       ctermfg=NONE  ctermbg=DarkGrey cterm=NONE
highlight MatchParen   ctermfg=Grey  ctermbg=Blue     cterm=NONE

" Errors and warnings highlighting
highlight ErrorMsg   ctermfg=NONE ctermbg=DarkRed cterm=NONE
highlight Error      ctermfg=NONE ctermbg=DarkRed cterm=NONE
highlight WarningMsg ctermfg=NONE ctermbg=208     cterm=NONE

" Diff highlights
highlight DiffAdd    ctermfg=NONE    ctermbg=DarkGreen cterm=NONE
highlight DiffChange ctermfg=NONE    ctermbg=3         cterm=NONE
highlight DiffDelete ctermfg=DarkRed ctermbg=DarkRed   cterm=NONE
highlight DiffText   ctermfg=NONE    ctermbg=3         cterm=underline

syntax enable
