
syn keyword zshConstant
            \ PATH

syn keyword zshKeyword
            \ export
            \ alias
            \ function
            \ local

syn keyword zshFunction
            \ echo
            \ printf
            \ sed

syn keyword zshConditional
            \ if
            \ then
            \ else
            \ elseif
            \ fi
            \ for
            \ do
            \ done

syn match zshConstant "\<[A-Z_]\{2,}\>\((\)\@!"
syn match zshOperator "(\|)\|\[\|\]\|=\||"
syn match zshDelimiter ";\|:\|/"

syn region zshComment start="#" end="$"
syn region zshString start="\"" end="\""
syn region zshString start="\'" end="\'"

hi def link zshConstant Constant
hi def link zshDelimiter Delimiter
hi def link zshOperator Operator
hi def link zshKeyword Keyword
hi def link zshConditional Conditional
hi def link zshComment Comment
hi def link zshFunction Function
hi def link zshString String

let b:current_syntax = "zsh"
