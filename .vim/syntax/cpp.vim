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
            \ throw
            \ using

syn keyword cppControl
            \ case
            \ default
            \ break
            \ catch
            \ continue
            \ else
            \ finally
            \ for
            \ if
            \ try
            \ while

syn keyword cppKeyword
            \ class
            \ explicit
            \ export
            \ inline
            \ namespace
            \ private
            \ protected
            \ public
            \ struct
            \ switch
            \ template
            \ typedef
            \ typename
            \ virtual

syn keyword cppConstant
            \ nan
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
            \ ifstream ofstream
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
            \ set
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

syn keyword cppCustomType
            \ Col
            \ Cube
            \ Mat
            \ Row
            \ colvec
            \ cube
            \ icube
            \ imat
            \ ivec
            \ mat
            \ rowvec
            \ span
            \ ucube
            \ umat
            \ uvec
            \ uword
            \ vec

syn match cppCast           "\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn match cppCast           "\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppConstant       "\<[A-Z_0-9]\{2,}\>\((\)\@!"
syn match cppDelimiter      "\[\|\]\|(\|)\|,\|{\|}\|;"
syn match cppFunction       "\w\+\s*(\@=\|\w\+<.*>\s*(\@="  contains=cppType,cppCustomType,cppNamespace,cppScopeDelimiter
syn match cppMemberVariable "\(\.\|-_\)\h\w*"
syn match cppNumber         "\<[0-9.]\+\>\|[0-9]e[0-9-]"
syn match cppOperator       "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|%\|\.\|->"
syn match cppScopeDelimiter "::"
syn match cppPreProc        "#\w*"
syn match cppString         "\(#include \)\@<=.*$"
syn match cppTodo           "\<FIXME\>\|\<TODO\>\|\<NOTE\>"
syn match cppType           "\<\w\+\>\( \<\w\+\>.=\)\@=\|\(const \)\@<=\<\w\+\>"
syn match cppNamespace      "\<\w\+\>\(::\)\@=\|\(namespace \)\@<=\<\w\+\>"
syn match cppStringFormat   "\\[nt]"                        contained

syn region cppComment  start="//"   end="$"    contains=cppTodo
syn region cppComment  start="\/\*" end="\*\/" contains=cppTodo
syn region cppString   start="\""   end="\""   contains=cppStringFormat
syn region cppChar     start="\'"   end="\'"

hi def link cppAccess             cppStatement
hi def link cppBoolean            Boolean
hi def link cppCast               cppStatement
hi def link cppChar               String
hi def link cppComment            Comment
hi def link cppConstant           Constant
hi def link cppControl            Statement
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
hi def link cppStringFormat       SpecialChar
hi def link cppTodo               Todo
hi def link cppType               Type
hi def link cppTypeModifier       Keyword

let b:current_syntax = "cpp"
