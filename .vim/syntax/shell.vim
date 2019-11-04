syn case match

syn keyword shellTodo contained
            \ FIXME
            \ NOTE
            \ TODO

syn keyword shellBoolean
            \ false
            \ no
            \ true
            \ yes

syn keyword shellKeyword
            \ alias
            \ export
            \ function
            \ set
            \ shopt
            \ source
            \ stty
            \ unset
            \ unsetopt

syn keyword shellRepeat
            \ do
            \ done
            \ for
            \ in

syn keyword shellConditional
            \ elif
            \ else
            \ fi
            \ if
            \ then

syn keyword shellConstant
            \ EDITOR
            \ HOME
            \ LESS
            \ PAGER
            \ PATH
            \ PWD
            \ TERM
            \ USER

syn keyword shellFunction
            \ cd
            \ cmake
            \ cp
            \ curl
            \ echo
            \ expr
            \ git
            \ head
            \ ln
            \ make
            \ man
            \ mv
            \ scp
            \ sed
            \ ssh
            \ tail
            \ wc
            \ wget

syn match shellConstant "\<[A-Z_]\{2,}\>\((\)\@!"
syn match shellKeyword "\.\W"
syn match shellProgram "\(^\|\s\)\@<=\(vim\|brew\|py\+\|pip\+\|ipi\|clang\|clang++\|gcc\|g++\|psql\|sql\)\>"
syn match shellNumber "\d"
syn match shellOperator "\.\|=\|\$\|\\\/\|!\|\\\|(\|)\|\.\/\||\|>"
syn match shellDelimiter "\[\|\]\|;\|:\|\~\|/\|{\|}"
syn match shellArgument "\( \)\@<=-\w\+\|\( \)\@<=--[A-z\-_]\+"
syn match shellExpand "\(\$[A-z]\+\)\|\${.*}"

syn region shellCharacter start=+'+ end=+'+
syn region shellString start=+"+ end=+"+ contains=shellConstant,shellExpand
syn region shellComment start=+#+ end="$" contains=shellTodo

hi def link shellConstant Constant
hi def link shellKeyword Keyword
hi def link shellOperator Operator
hi def link shellDelimiter Delimiter
hi def link shellCharacter Character
hi def link shellFunction Function
hi def link shellProgram Function
hi def link shellNumber Number
hi def link shellString String
hi def link shellTodo Todo
hi def link shellComment Comment
hi def link shellExpand SpecialChar
hi def link shellArgument Special
hi def link shellConditional Conditional
hi def link shellRepeat Repeat
hi def link shellBoolean Boolean

let b:current_syntax="shell"
