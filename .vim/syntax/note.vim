
" general
syn match noteList "-\|*\|+"
syn match noteDelimiter "(\|)\|\[\|\]"
syn match noteLogic "->\|=>"
syn match noteProperNoun "\<[A-Z]\w\+\>"

" math
syn match noteMathCommand "\\\<\w\+\>\|\\\\" contained
syn match noteMathCommandArgument "{\|}" contained
syn match noteMathNumber "[0-9]\|[0-9.]" contained
syn match noteMathOperator "_\|\^\|+\|-\|/\|*" contained

" regions
syn region noteEmphasis start="__" end="__"
syn region noteEmphasis start="\*\*" end="\*\*"
syn region noteSection start="^#" end="$"
syn region noteNested start="{" end="}"
syn region noteCodeBlock start="```" end="```"
syn region notePreamble start="\%1l---$" end="^---$"
syn region noteCodeInline start="`" end="`"
syn region noteQuote start="\"" end="\""
syn region noteQuestion start="?" end="$\|?"
syn region noteAction start="!" end="$\|!"
syn region noteAside start="(" end=")"
syn region noteMathDisplay start="\$\$" end="\$\$" contains=noteMathCommand,noteMathCommandArgument,noteMathNumber,noteMathOperator
syn region noteMathInline start="\$\([A-z\\0-9(\[{]\)\@=" end="\([A-z0-9\])}]\)\@<=\$" contains=noteMathCommand,noteMathCommandArgument,noteMathNumber,noteMathOperator
syn region noteTodo start="\[\]" end="$"
syn region noteDone start="\[x\]" end="$"

" color links
hi def link noteList Operator
hi def link noteDelimiter Delimiter

" custom colors
highlight noteProperNoun ctermfg=DarkMagenta ctermbg=NONE
highlight noteNested ctermfg=NONE ctermbg=DarkBlue
highlight noteQuestion ctermfg=Green ctermbg=DarkGreen
highlight noteAside ctermfg=Blue ctermbg=Black
highlight noteLogic ctermfg=Magenta ctermbg=NONE
highlight noteAction ctermfg=Red ctermbg=DarkRed
highlight noteQuote ctermfg=Yellow ctermbg=NONE
highlight noteCodeBlock ctermfg=Black ctermbg=DarkGrey
highlight noteCodeInline ctermfg=Black ctermbg=DarkGrey
highlight noteEmphasis ctermbg=Black cterm=Bold
highlight noteSection ctermfg=DarkYellow cterm=underline
highlight noteCommand ctermfg=Cyan ctermbg=DarkCyan
highlight notePreamble ctermbg=Black ctermfg=DarkRed
highlight noteMathCommand ctermfg=Black ctermbg=Black
highlight noteMathCommandArgument ctermfg=DarkYellow ctermbg=Black
highlight noteMathNumber ctermfg=Red ctermbg=Black
highlight noteMathOperator ctermfg=Yellow ctermbg=Black
highlight noteMathInline ctermfg=Green ctermbg=Black
highlight noteMathDisplay ctermfg=Green ctermbg=Black
highlight noteTodo ctermfg=DarkRed ctermbg=NONE
highlight noteDone ctermfg=DarkGreen ctermbg=NONE
