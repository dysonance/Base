syn keyword pythonPackage
      \ numpy np
      \ pandas pd
      \ matplotlib
      \ datetime dt
      \ logging log
      \ numba

syn keyword pythonStatement
      \ def return
      \ import as from
      \ assert

syn keyword pythonBuiltin
      \ True False None

syn keyword pythonType
      \ int float bool
      \ str

syn keyword pythonCustomType
      \ DataFrame Series
      \ array

syn keyword pythonKeyword
      \ class self cls
      \ if else elif try catch finally
      \ for while

syn match pythonConstant  "\<[A-Z_]\{2,}\>\((\)\@!\|\<nan\>\|\<NaN\>\|\<NA\>"
syn match pythonDecorator "@\@<=\w*\|@"
syn match pythonDelimiter "\[\|\]\|(\|)\|,\|{\|}\|;"
syn match pythonFunction  "\(def \)\@<=\w*"
syn match pythonNumber    "\<[0-9.]\+\>"
syn match pythonOperator  "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|%\|\."

syn region pythonComment start="#"      end="\n"
syn region pythonString  start="\"\"\"" end="\"\"\""
syn region pythonString  start=+"+      end=+"+
syn region pythonString  start=+'+      end=+'+

hi def link pythonBuiltin    Constant
hi def link pythonComment    Comment
hi def link pythonConstant   Constant
hi def link pythonCustomType Type
hi def link pythonDecorator  PreProc
hi def link pythonDelimiter  Delimiter
hi def link pythonFunction   Operator
hi def link pythonKeyword    Keyword
hi def link pythonNumber     Number
hi def link pythonOperator   Operator
hi def link pythonPackage    PreProc
hi def link pythonStatement  Statement
hi def link pythonString     String
hi def link pythonType       Type

let b:current_syntax = "python"
