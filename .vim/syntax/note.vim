
" general
syn match noteList "-\|*\|+"
syn match noteDelimiter "(\|)\|\[\|\]"
syn match noteLogic "->\|=>"

" math
syn match noteMathCommand "\\\<\w\+\>\|\\\\" contained
syn match noteMathCommandArgument "{\|}" contained
syn match noteMathNumber "[0-9]\|[0-9.]" contained
syn match noteMathOperator "_\|\^\|+\|-\|/\|*" contained
syn region noteMathDisplay start="\$\$" end="\$\$" contains=noteMathCommand,noteMathCommandArgument,noteMathNumber,noteMathOperator
syn region noteMathInline start="\$\([A-z\\0-9(\[{]\)\@=" end="\([A-z0-9\])}]\)\@<=\$" contains=noteMathCommand,noteMathCommandArgument,noteMathNumber,noteMathOperator

" regions
syn region noteEmphasis start="__" end="__"
syn region noteEmphasis start="\*\*" end="\*\*"
syn region noteSection start="^#" end="$"
syn region noteCodeBlock start="```" end="```"
syn region notePreamble start="\%1l---$" end="^---$"
syn region noteCodeInline start="`" end="`"

syn region noteQuestion start="?" end="$\|?"
syn region noteAside start="(" end=")"

" color links
hi def link noteList Operator
hi def link noteDelimiter Delimiter

" custom colors
highlight noteQuestion ctermfg=Green ctermbg=Black
highlight noteAside ctermfg=Blue ctermbg=Black
highlight noteLogic ctermfg=Magenta ctermbg=NONE

highlight noteEmphasis ctermbg=Black cterm=Bold
highlight noteSection ctermfg=DarkYellow cterm=underline
highlight noteCodeBlock ctermfg=Black ctermbg=DarkGrey
highlight noteCodeInline ctermfg=Black ctermbg=DarkGrey
highlight noteCommand ctermfg=Cyan ctermbg=DarkCyan
highlight notePreamble ctermbg=Black ctermfg=DarkRed
highlight noteMathCommand ctermfg=Black ctermbg=DarkGreen
highlight noteMathCommandArgument ctermfg=DarkYellow ctermbg=DarkGreen
highlight noteMathNumber ctermfg=Red ctermbg=DarkGreen
highlight noteMathOperator ctermfg=Yellow ctermbg=DarkGreen
highlight noteMathInline ctermfg=Green ctermbg=DarkGreen
highlight noteMathDisplay ctermfg=Green ctermbg=DarkGreen
