syn keyword cppOperator
            \ and
            \ and_eq
            \ bitand
            \ bitor
            \ compl
            \ not
            \ not_eq
            \ operator
            \ or
            \ or_eq
            \ typeid
            \ xor
            \ xor_eq

syn keyword cppStatement
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
            \ using

syn keyword cppKeyword
            \ break
            \ catch
            \ class
            \ else
            \ explicit
            \ export
            \ finally
            \ for
            \ if
            \ inline
            \ namespace
            \ private
            \ protected
            \ public
            \ struct
            \ template
            \ try
            \ typedef
            \ typename
            \ virtual
            \ while

syn keyword cppConstant
            \ nullptr

syn keyword cppBoolean
            \ false
            \ true

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
            \ mutable
            \ normal_distribution
            \ pair
            \ random_device
            \ shared_ptr
            \ static
            \ string
            \ thread_local
            \ tuple
            \ uniform_int_distribution
            \ uniform_real_distribution
            \ unsigned
            \ vector
            \ void

syn keyword cppCustomType
            \ Col
            \ Mat
            \ Row
            \ colvec
            \ cube
            \ imat
            \ ivec
            \ mat
            \ rowvec
            \ umat
            \ uvec
            \ vec

syn match cppCast           "\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn match cppCast           "\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppConstant       "\<[A-Z_]\{2,}\>\((\)\@!"
syn match cppDelimiter      "\[\|\]\|(\|)\|,\|{\|}\|;"
syn match cppFunction       "\w\+\s*(\@=\|\w\+<.*>\s*(\@=" contains=cppType,cppCustomType,cppNamespace,cppScopeDelimiter
syn match cppMemberVariable "\(\.\|-_\)\h\w*"
syn match cppNumber         "\<[0-9.]\+\>\|[0-9]e[0-9-]"
syn match cppOperator       "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|%\|\.\|->"
syn match cppScopeDelimiter "::"
syn match cppPreProc        "#\w*"
syn match cppString         "\(#include \)\@<=.*$"
syn match cppTodo           "\<FIXME\>\|\<TODO\>\|\<NOTE\>"
syn match cppNamespace      "\<\w\+\>\(::\)\@=\|\(namespace \)\@<=\<\w\+\>"
syn match cppType           "\<\w\+\>\( \<\w\+\>.=\)\@=\|\(const \)\@<=\<\w\+\>\@!\(::\)"

syn region cppComment  start="//"   end="$"    contains=cppTodo
syn region cppComment  start="\/\*" end="\*\/" contains=cppTodo
syn region cppChar     start="\'"   end="\'"
syn region cppString   start="\""   end="\""

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
hi def link cppScopeDelimiter     Special
hi def link cppStatement          Statement
hi def link cppStorageClass       StorageClass
hi def link cppString             String
hi def link cppStructure          Structure
hi def link cppTodo               Todo
hi def link cppType               Type
hi def link cppTypeModifier       Keyword

let b:current_syntax = "cpp"
