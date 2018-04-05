" General highlighting
highlight Normal     ctermfg=White  ctermbg=DarkBlue cterm=NONE
highlight Comment    ctermfg=Blue   ctermbg=NONE     cterm=NONE
highlight Identifier ctermfg=White  ctermbg=NONE     cterm=NONE
highlight Function   ctermfg=Yellow ctermbg=NONE     cterm=NONE

" Constant highlighting group
highlight Constant  ctermfg=Red   ctermbg=NONE cterm=NONE
highlight Number    ctermfg=Red   ctermbg=NONE cterm=NONE
highlight Float     ctermfg=Red   ctermbg=NONE cterm=NONE
highlight Boolean   ctermfg=Red   ctermbg=NONE cterm=NONE
highlight String    ctermfg=Green ctermbg=NONE cterm=NONE
highlight Character ctermfg=Green ctermbg=NONE cterm=NONE

" Statement highlighting group
highlight Statement   ctermfg=Cyan       ctermbg=NONE cterm=NONE
highlight Conditional ctermfg=Cyan       ctermbg=NONE cterm=NONE
highlight Repeat      ctermfg=Cyan       ctermbg=NONE cterm=NONE
highlight Operator    ctermfg=Yellow     ctermbg=NONE cterm=NONE
highlight Keyword     ctermfg=Magenta    ctermbg=NONE cterm=NONE
highlight PreProc     ctermfg=DarkYellow ctermbg=NONE cterm=NONE

" Special highlighting group
highlight Special     ctermfg=Magenta    ctermbg=NONE  cterm=NONE
highlight Delimiter   ctermfg=Cyan       ctermbg=NONE  cterm=NONE
highlight SpecialChar ctermfg=DarkYellow ctermbg=NONE  cterm=NONE
highlight Tag         ctermfg=Magenta    ctermbg=NONE  cterm=NONE
highlight Todo        ctermfg=Yellow     ctermbg=Black cterm=NONE
highlight Type        ctermfg=Magenta    ctermbg=NONE  cterm=NONE

" Other random highlights
set cursorline
highlight CursorLine ctermfg=NONE  ctermbg=NONE      cterm=underline
highlight StatusLine ctermfg=Blue  ctermbg=Cyan      cterm=NONE
highlight LineNR     ctermfg=Grey  ctermbg=NONE      cterm=NONE
highlight Pmenu      ctermfg=Black ctermbg=Cyan      cterm=NONE
highlight PmenuSel   ctermfg=White ctermbg=DarkCyan  cterm=NONE
highlight Visual     ctermfg=NONE  ctermbg=DarkGrey  cterm=NONE
highlight IncSearch  ctermfg=Black ctermbg=DarkGreen cterm=NONE
highlight Search     ctermfg=Black ctermbg=DarkGreen cterm=NONE
highlight MatchParen ctermfg=Grey  ctermbg=Blue      cterm=NONE

" Errors and warnings highlighting
highlight ErrorMsg   ctermfg=NONE ctermbg=DarkRed    cterm=NONE
highlight Error      ctermfg=NONE ctermbg=DarkRed    cterm=NONE
highlight WarningMsg ctermfg=NONE ctermbg=DarkYellow cterm=NONE

" Diff highlights
highlight DiffAdd    ctermfg=NONE ctermbg=DarkGreen cterm=NONE
highlight DiffChange ctermfg=NONE ctermbg=Black     cterm=NONE
highlight DiffDelete ctermfg=NONE ctermbg=DarkRed   cterm=NONE
highlight DiffText   ctermfg=NONE ctermbg=Blue      cterm=NONE

syntax enable
