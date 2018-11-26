scriptencoding utf-8

syn case match

syn keyword juliaTodo contained TODO FIXME NOTE XXX

syn keyword juliaStatement using import return

syn keyword juliaModule
            \ Base
            \ Test
            \ Statistics

syn keyword juliaKeyword
            \ true false
            \ for while if else elseif begin end try catch finally let call block quote macro
            \ const local global module
            \ function type typealias abstract struct mutable bitstype

syn keyword juliaType
            \ Any Type Union Missing
            \ Number Complex Real
            \ AbstractIrrational Rational Irrational
            \ Integer Bool Signed Unsigned Int BigInt Int16 Int32 Int64 Int8 Int128 UInt128 UInt16 UInt32 UInt64 UInt8
            \ AbstractFloat BigFloat Float16 Float32 Float64
            \ AbstractString AbstractChar String Char Symbol SubString SubstitutionString
            \ AbstractArray AbstractMatrix AbstractVector
            \ AbstractUnitRange AbstractRange LinRange OrdinalRange StepRangeLen
            \ Array Matrix Vector VecOrMat UnitRange
            \ AbstractDict AbstractSet Dict Set Tuple NTuple NamedTuple

syn keyword juliaCustomType
            \ DataFrame
            \ TS

syn match juliaOperator  "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|::\|%\|\.\.\.\|\."
syn match juliaDelimiter '\[\|\]\|(\|)\|,\|{\|}\|;'
syn match juliaDelimiter ">\((\|;\)\@="
syn match juliaDelimiter "\(\w\)\@<=<"
syn match juliaConstant  '\<[A-Z_]\+\>\((\)\@!'
syn match juliaNumber    "[0-9]"
syn match juliaNumber    "[0-9].[0-9]"
syn match juliaNumber    ".[0-9]"
syn match juliaSymbol    ":\@!:\(\w\)\+"
syn match juliaSpecial   "[$@]\(\w\)+\|`"
syn match juliaComment   "#.*$"   contains=juliaTodo
syn match juliaComment   "#=.*=#" contains=juliaTodo

syn region juliaString    start=+"+ end=+"+  skip=+\\\\\|\\"+ contains=juliaVariable
syn region juliaCharacter start=+'+ end=+'+  skip=+\\\\\|\\'+ contains=juliaVariable

hi def link juliaCharacter  Character
hi def link juliaComment    Comment
hi def link juliaConstant   Constant
hi def link juliaCustomType Type
hi def link juliaDelimiter  Delimiter
hi def link juliaKeyword    Special
hi def link juliaModule     PreProc
hi def link juliaNumber     Number
hi def link juliaOperator   Operator
hi def link juliaSpecial    SpecialChar
hi def link juliaStatement  Statement
hi def link juliaString     String
hi def link juliaSymbol     String
hi def link juliaTodo       Todo
hi def link juliaType       Type
hi def link juliaVariable   Identifier

let b:current_syntax = "julia"
