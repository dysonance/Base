" latex/math
syn match pandocMathCommand "\\\<\w\+\>\|\\\\" contained
syn match pandocMathCommandArgument "{\|}" contained
syn match pandocMathNumber "[0-9]\|[0-9.]" contained
syn match pandocMathOperator "_\|\^\|+\|-\|/\|*" contained
syn region pandocMathDisplay start="\$\$" end="\$\$" contains=pandocMathCommand,pandocMathCommandArgument,pandocMathNumber,pandocMathOperator
syn region pandocMathInline start="\$\([A-z\\0-9(\[{]\)\@=" end="\([A-z0-9\])}]\)\@<=\$" contains=pandocMathCommand,pandocMathCommandArgument,pandocMathNumber,pandocMathOperator
highlight pandocMathCommand ctermfg=Black ctermbg=DarkGreen
highlight pandocMathCommandArgument ctermfg=DarkYellow ctermbg=DarkGreen
highlight pandocMathNumber ctermfg=Red ctermbg=DarkGreen
highlight pandocMathOperator ctermfg=Yellow ctermbg=DarkGreen
highlight pandocMathInline ctermfg=Green ctermbg=DarkGreen
highlight pandocMathDisplay ctermfg=Green ctermbg=DarkGreen

" general syntax
syn match pandocPreambleVariable "[a-z-]\+[:=]" contained
syn match pandocCommand "\\\<\w\+\>\|^---$"
syn region pandocEmphasis start="__" end="__"
syn region pandocEmphasis start="\*\*" end="\*\*"
syn region pandocSection start="^#" end="$"
syn region pandocCodeBlock start="```" end="```"
syn region pandocPreamble start="\%1l---$" end="^---$"
syn region pandocCodeInline start="`" end="`"
highlight pandocEmphasis ctermbg=Black cterm=Bold
highlight pandocSection ctermfg=DarkYellow cterm=underline
highlight pandocCodeBlock ctermfg=Black ctermbg=DarkGrey
highlight pandocCodeInline ctermfg=Black ctermbg=DarkGrey
highlight pandocCommand ctermfg=Cyan ctermbg=DarkCyan
highlight pandocPreamble ctermbg=Black ctermfg=DarkRed

" syntax options
syn case match
setlocal nospell
setlocal wrap
let b:current_syntax = "pandoc"
