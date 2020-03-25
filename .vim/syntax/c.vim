syn keyword cStatement
            \ const_cast
            \ cin
            \ cout
            \ delete
            \ dynamic_cast
            \ endl
            \ friend
            \ make_shared
            \ new
            \ reinterpret_cast
            \ return
            \ static_cast
            \ this
            \ throw
            \ using

syn keyword cTypeModifier
            \ const
            \ static

syn keyword cType
            \ auto
            \ bool
            \ char
            \ chi_squared_distribution
            \ default_random_engine
            \ deque
            \ double
            \ enum
            \ float
            \ function
            \ hash
            \ int
            \ istringstream
            \ list
            \ long
            \ map
            \ mt19937
            \ mutable
            \ normal_distribution
            \ ostream
            \ ostringstream
            \ pair
            \ random_device
            \ shared_ptr
            \ static
            \ string
            \ stringstream
            \ thread_local
            \ tuple
            \ uniform_int_distribution
            \ uniform_real_distribution
            \ unsigned
            \ vector
            \ void
            \ wistringstream
            \ wostringstream

syn match cConstant  "\<[A-Z_]\{2,}\>\((\)\@!"
syn match cDelimiter "\[\|\]\|(\|)\|,\|{\|}\|;"
syn match cFunction  "\w\+\s*(\@=\|\w\+<.*>\s*(\@="  contains=cType,cCustomType,cNamespace,cScopeDelimiter
syn match cNumber    "\<[0-9.]\+\>\|[0-9]e[0-9-]"
syn match cOperator  "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|%\|\.\|->"
syn match cPreProc   "#\w*"
syn match cString    "\(#include \)\@<=.*$"
syn match cTodo      "\<FIXME\>\|\<TODO\>\|\<NOTE\>"

syn region cComment start="//"   end="$"    contains=cTodo
syn region cComment start="\/\*" end="\*\/" contains=cTodo
syn region cString  start="\""   end="\""   contains=cStringFormat
syn region cChar    start="\'"   end="\'"

hi def link cChar         String
hi def link cComment      Comment
hi def link cConstant     Constant
hi def link cDelimiter    Delimiter
hi def link cFunction     Function
hi def link cKeyword      Keyword
hi def link cNumber       Number
hi def link cOperator     Operator
hi def link cPreProc      PreProc
hi def link cStatement    Statement
hi def link cString       String
hi def link cStringFormat SpecialChar
hi def link cTodo         Todo
hi def link cType         Type
hi def link cTypeModifier Keyword

let b:current_syntax = "c"
