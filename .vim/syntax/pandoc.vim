" general
syn match pandocMathCommand "\\\<\w\+\>\|\\\\" contained
syn match pandocMathCommandArgument "{\|}" contained
syn match pandocMathNumber "[0-9]\|[0-9.]" contained
syn match pandocMathOperator "_\|\^\|+\|-\|/\|*" contained
syn match pandocPreambleVariable "[a-z-]\+[:=]" contained
syn match pandocCommand "\\\<\w\+\>\|^---$"
syn match pandocHyperlink "\[.*\]\((\)\@="
syn match pandocList "\*\|-"

" regions
syn region pandocMathDisplay start="\$\$" end="\$\$" contains=pandocMathCommand,pandocMathCommandArgument,pandocMathNumber,pandocMathOperator
syn region pandocMathInline start="\$\([A-z\\0-9(\[{]\)\@=" end="\([A-z0%-9\])}]\)\@<=\$" contains=pandocMathCommand,pandocMathCommandArgument,pandocMathNumber,pandocMathOperator
syn region pandocEmphasis start="__" end="__"
syn region pandocEmphasis start="\*\*" end="\*\*"
syn region pandocSection start="^#" end="$"
syn region pandocCodeBlock start="```" end="```"
syn region pandocPreamble start="\%1l---$" end="^---$"
syn region pandocCodeInline start="`" end="`"
syn region pandocTodo start="\[ \]" end="$"
syn region pandocDone start="\[x\]" end="$"
syn region pandocURL start="\((\)\?https://\|https://\|www\." end="\s\|$\|)"
syn region pandocQuestion start="Q:" end="?\|$"

" highlighting rules
hi def link pandocList Operator
highlight pandocHyperlink ctermfg=Cyan ctermbg=NONE cterm=underline
highlight pandocURL ctermfg=Blue ctermbg=NONE cterm=underline
highlight pandocMathCommand ctermfg=Black ctermbg=DarkGreen
highlight pandocMathCommandArgument ctermfg=DarkYellow ctermbg=DarkGreen
highlight pandocMathNumber ctermfg=Red ctermbg=DarkGreen
highlight pandocMathOperator ctermfg=Yellow ctermbg=DarkGreen
highlight pandocMathInline ctermfg=Green ctermbg=DarkGreen
highlight pandocMathDisplay ctermfg=Green ctermbg=DarkGreen
highlight pandocEmphasis ctermbg=Black cterm=Bold
highlight pandocSection ctermfg=DarkYellow cterm=underline
highlight pandocCodeBlock ctermfg=Black ctermbg=DarkGrey
highlight pandocCodeInline ctermfg=Black ctermbg=DarkGrey
highlight pandocCommand ctermfg=Cyan ctermbg=DarkCyan
highlight pandocPreamble ctermbg=Black ctermfg=DarkRed
highlight pandocTodo ctermfg=DarkRed ctermbg=NONE
highlight pandocDone ctermfg=DarkGreen ctermbg=NONE
highlight pandocQuestion ctermfg=Green ctermbg=Black

" syntax options
syn case match
setlocal nospell
setlocal wrap
let b:current_syntax = "pandoc"
