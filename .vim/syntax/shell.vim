" syn case match

" syn keyword shellTodo contained
"             \ TODO
"             \ FIXME
"             \ NOTE

" syn keyword shellKeyword
"             \ export
"             \ unset
"             \ if
"             \ elif
"             \ else
"             \ fi
"             \ for
"             \ do
"             \ done

" syn keyword shellConstant
"             \ TRUE
"             \ FALSE

" syn keyword shellFunction
"             \ source
"             \ git
"             \ wget
"             \ man

" syn keyword shellEnvironmentVariable
"             \ HOME
"             \ PATH

" syn match shellConstant "\<[A-Z_]\{2,}\>\|\(export \)\@<=\<\w\+\>"
" syn match shellNumber "\d"
" syn match shellOperator "\.\|=\|\$"
" syn match shellDelimiter "\[\|\]\|;\|:\|/"
" syn match shellEnvironmentVariable "\$\<[A-Z]\+\>"

" syn region shellCharacter start=+'+ end=+'+
" syn region shellString start=+"+ end=+"+ contains=shellConstant,shellDelimiter
" syn region shellComment start=+#+ end="$" contains=shellTodo

" hi def link shellConstant Constant
" hi def link shellKeyword Keyword
" hi def link shellOperator Operator
" hi def link shellDelimiter Delimiter
" hi def link shellCharacter Character
" hi def link shellFunction Function
" hi def link shellNumber Number
" hi def link shellString String
" hi def link shellTodo Todo
" hi def link shellComment Comment

" let b:current_syntax="shell"
