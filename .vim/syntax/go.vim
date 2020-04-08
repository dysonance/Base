syn case match

syn keyword goTodo
            \ TODO
            \ FIXME
            \ NOTE

syn keyword goKeyword
            \ const
            \ for
            \ package
            \ range
            \ this
            \ var
            \ while

syn keyword goStatement
            \ continue
            \ func
            \ import
            \ return
            \ struct
            \ type

syn keyword goType
            \ bool
            \ error
            \ float64
            \ int
            \ interface
            \ map
            \ string

syn keyword goControl
            \ case
            \ else
            \ if
            \ while

syn keyword goBoolean
            \ false
            \ true

syn keyword goPackage
            \ beego
            \ fmt
            \ io
            \ json
            \ math
            \ orm
            \ os
            \ sort
            \ strconv
            \ strings
            \ template
            \ testing
            \ time

syn keyword goConstant
            \ nil

syn match goConstant  "\<[A-Z_]\{2,}\>\((\)\@!\|\<nan\>\|\<NaN\>\|\<NA\>"
syn match goDelimiter "(\|)\|;\|\[\|\]\|{\|}\|,"
syn match goFunction  "\<\w\+\>(\@=\|\.\@<=\w*\[" contains=goDelimiter
syn match goOperator  "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|%\|\."
syn match goMethod    "\(func (\w*)\)"
syn match goNumber    "\<[0-9_.]\+\>\|[0-9_]\+e[0-9-]\+"
syn match goFormat    "%\(d\|s\|f\|v\|T\|t\|x\|e\|E\|q\|x\|p\)\|\\n\|\\t" containedin=goString,goRawString

syn region goString    start="\"" end="\""
syn region goRawString start="`"  end="`"
syn region goComment   start="//" end="$" contains=goTodo

hi def link goTodo      Todo
hi def link goBoolean   Boolean
hi def link goConstant  Constant
hi def link goString    String
hi def link goRawString String
hi def link goKeyword   Keyword
hi def link goDelimiter Delimiter
hi def link goPackage   PreProc
hi def link goFunction  Function
hi def link goOperator  Operator
hi def link goStatement Keyword
hi def link goMethod    SpecialChar
hi def link goControl   Statement
hi def link goComment   Comment
hi def link goNumber    Number
hi def link goType      Type
hi def link goFormat    SpecialChar

let b:current_syntax = "go"
