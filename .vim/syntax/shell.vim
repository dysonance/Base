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
            \ eval
            \ exec
            \ exit
            \ export
            \ function
            \ let
            \ local
            \ return
            \ set
            \ setopt
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
            \ continue
            \ break
            \ while

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
            \ cat
            \ cd
            \ clear
            \ cmake
            \ cp
            \ curl
            \ deactivate
            \ echo
            \ expr
            \ find
            \ git
            \ go
            \ head
            \ ln
            \ make
            \ man
            \ mkdir
            \ mv
            \ popd
            \ printf
            \ pushd
            \ python
            \ python3
            \ rm
            \ scp
            \ sed
            \ ssh
            \ tail
            \ touch
            \ wc
            \ wget
            \ xargs

syn match shellCommand   "^\<\w\+\>"
syn match shellConstant  "\<[A-Z0-9_]\{2,}\>\((\)\@!"
syn match shellProgram   "\(^\|\s\)\@<=\(vim\|brew\|python\+\|pip\+\|clang\|clang++\|gcc\|g++\|psql\|sql\|tar\)\>"
syn match shellNumber    "\<\d\+\>"
syn match shellOperator  "\.\|=\|\\\/\|!\|\\\|\.\/\||\|>\|&\||"
syn match shellDelimiter "\[\|\]\|;\|:\|\~\|/\|{\|}\|(\|)"
syn match shellArgument  "\(\s\)\@<=-\w\+\|\(\s\)\@<=--[A-z\-_0-9]\+\|\$[0-9]\|\$@"
syn match shellKeyword   "\(^\|\s\)\@<=\(\.\/\S\+\|sh\|bash\|zsh\)\>"
syn match shellFunction  "\(function \)\@<=\w\+"
syn match shellFormat    "\(\$[A-z0-9]\+\)\|\\t\|\\n" contained
syn match shellVariable  "\(\$[A-z0-9]\+\)\|\\t\|\\n"

syn region shellComment   start=+#+   end="$" contains=shellTodo
syn region shellExpand    start="\${" end="}" contains=ALL keepend
syn region shellExpand    start="\$(" end=")" contains=ALL keepend
syn region shellCharacter start=+'+   end=+'+ extend
syn region shellString    start=+"+   end=+"+ skip="\\\""  contains=shellExpand,shellFormat,shellVariable keepend extend

hi def link shellCommand     Function
hi def link shellConstant    Constant
hi def link shellKeyword     Keyword
hi def link shellOperator    Operator
hi def link shellDelimiter   Delimiter
hi def link shellCharacter   Character
hi def link shellFunction    Function
hi def link shellProgram     Function
hi def link shellNumber      Number
hi def link shellString      String
hi def link shellTodo        Todo
hi def link shellComment     Comment
hi def link shellFormat      SpecialChar
hi def link shellExpand      SpecialChar
hi def link shellVariable    SpecialChar
hi def link shellArgument    Special
hi def link shellConditional Conditional
hi def link shellRepeat      Repeat
hi def link shellBoolean     Boolean

let b:current_syntax="shell"
