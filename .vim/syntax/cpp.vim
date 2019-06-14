syn keyword cppOperator
            \ operator
            \ typeid
            \ and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq

syn keyword cppStatement
            \ return
            \ using
            \ new delete this
            \ friend
            \ static_cast dynamic_cast reinterpret_cast const_cast

syn keyword cppKeyword
            \ for while
            \ if else
            \ try catch finally break
            \ inline virtual explicit export public protected private
            \ class struct typename template namespace typedef

syn keyword cppConstant
            \ nullptr

syn keyword cppBoolean
            \ true false

syn keyword cppTypeModifier
            \ const
            \ static

syn keyword cppType
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
            \ list
            \ long
            \ map
            \ mt19937
            \ normal_distribution
            \ pair
            \ random_device
            \ shared_ptr
            \ static mutable
            \ string
            \ thread_local
            \ tuple
            \ uniform_int_distribution
            \ uniform_real_distribution
            \ unsigned
            \ vector
            \ void

syn keyword cppCustomType
            \ vec colvec ivec uvec Col Row
            \ mat imat umat Mat
            \ cube

syn match cppCast           "\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn match cppCast           "\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppConstant       "\<[A-Z_]\{2,}\>\((\)\@!"
syn match cppDelimiter      "\[\|\]\|(\|)\|,\|{\|}\|;"
syn match cppFunction       "\w\+\s*(\@=\|\w\+<.*>\s*(\@=" contains=cppType,cppCustomType
syn match cppMemberVariable "\(\.\|-_\)\h\w*"
syn match cppNamespace      "\w\+\s*::" contains=cppScopeDelimiter
syn match cppNumber         "\<[0-9.]\+\>\|[0-9]e[0-9-]"
syn match cppOperator       "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|::\|%\|\.\|->"
syn match cppPreProc        "#\w*"
syn match cppScopeDelimiter "::"
syn match cppString         "\(#include \)\@<=.*$"
syn match cppTodo           "\<FIXME\>\|\<TODO\>\|\<NOTE\>"
syn match cppType           "< \w\+ >" contains=cppOperator
syn match cppType           "\<\w\+\>\( \<\w\+\>.=\)\@=\|\(const \)\@<=\<\w\+\>\@!\(::\)"

syn region cppChar    start="\'"   end="\'"
syn region cppComment start="//"   end="$"    contains=cppTodo
syn region cppComment start="\/\*" end="\*\/" contains=cppTodo
syn region cppString  start="\""   end="\""

hi def link cppAccess             cppStatement
hi def link cppBoolean            Boolean
hi def link cppCast               cppStatement
hi def link cppChar               String
hi def link cppComment            Comment
hi def link cppConstant           Constant
hi def link cppConstant           Constant
hi def link cppCustomType         Type
hi def link cppDelimiter          Delimiter
hi def link cppExceptions         Exception
hi def link cppFunction           Function
hi def link cppKeyword            Keyword
hi def link cppModifier           Type
hi def link cppNamespace          PreProc
hi def link cppNumber             Number
hi def link cppOperator           Operator
hi def link cppPreProc            PreProc
hi def link cppRawString          String
hi def link cppRawStringDelimiter Delimiter
hi def link cppScopeDelimiter     Delimiter
hi def link cppStatement          Statement
hi def link cppStorageClass       StorageClass
hi def link cppString             String
hi def link cppStructure          Structure
hi def link cppTodo               Todo
hi def link cppType               Type
hi def link cppTypeModifier       Keyword

let b:current_syntax = "cpp"
