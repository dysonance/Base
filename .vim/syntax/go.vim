syn case match

syn keyword goKeyword
            \ import package
            \ for while range

syn keyword goStatement
            \ func
            \ type struct

syn keyword goBoolean
            \ true false

syn keyword goPackage
            \ fmt
            \ time
            \ sort
            \ orm

syn match goDelimiter "(\|)\|;\|\[\|\]\|{\|}\|,"
syn match goFunction  "\<\w\+\>(\@=\|\.\@<=\w*\["
syn match goOperator  "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|%\|\."
syn match goMethod    "\(func (\w*)\)"

hi def link goBoolean   Boolean
hi def link goKeyword   Keyword
hi def link goDelimiter Delimiter
hi def link goPackage   PreProc
hi def link goFunction  Function
hi def link goOperator  Operator
hi def link goStatement Keyword
hi def link goMethod    SpecialChar
