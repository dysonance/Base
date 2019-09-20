syn case match

syn keyword goKeyword
            \ for
            \ package
            \ range
            \ this
            \ while

syn keyword goStatement
            \ func
            \ import
            \ struct
            \ type

syn keyword goBoolean
            \ false
            \ true

syn keyword goPackage
            \ beego
            \ fmt
            \ math
            \ orm
            \ os
            \ sort
            \ strconv
            \ strings
            \ testing
            \ time

syn match goConstant  "\<[A-Z_]\{2,}\>\((\)\@!\|\<nan\>\|\<NaN\>\|\<NA\>"
syn match goDelimiter "(\|)\|;\|\[\|\]\|{\|}\|,"
syn match goFunction  "\<\w\+\>(\@=\|\.\@<=\w*\[" contains=goDelimiter
syn match goOperator  "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|%\|\."
syn match goMethod    "\(func (\w*)\)"

hi def link goBoolean   Boolean
hi def link goConstant  Constant
hi def link goKeyword   Keyword
hi def link goDelimiter Delimiter
hi def link goPackage   PreProc
hi def link goFunction  Function
hi def link goOperator  Operator
hi def link goStatement Keyword
hi def link goMethod    SpecialChar
