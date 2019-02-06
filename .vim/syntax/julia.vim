scriptencoding utf-8

syn case match

syn keyword juliaTodo contained
            \ TODO FIXME NOTE

syn keyword juliaEnd contained
            \ end

syn keyword juliaStatement 
            \ using import return
            \ let call begin do
            \ try catch finally continue break

syn keyword juliaModule
            \ Base Base64
            \ Core
            \ Distributed
            \ Future
            \ LinearAlgebra
            \ Pkg
            \ Printf
            \ Dates
            \ Random
            \ REPL
            \ Statistics
            \ Test

syn keyword juliaCustomModule
            \ Documenter
            \ Plots
            \ Distributions
            \ HTTP
            \ GR
            \ JuMP
            \ Temporal
            \ Indicators
            \ Strategems
            \ JuliaDB
            \ DataStreams
            \ DataFrames
            \ TimeSeries
            \ IterableTables

syn keyword juliaKeyword
            \ where
            \ for in while if else elseif end
            \ try catch finally
            \ block quote macro
            \ const local global module
            \ function type typealias abstract struct mutable bitstype

syn keyword juliaBoolean
            \ true false

syn keyword juliaConstant
            \ nothing
            \ missing

syn keyword juliaType
            \ Any Type Union Missing Callable Nothing Vararg Function Expr VersionNumber Void
            \ Number Complex Real
            \ AbstractIrrational Rational Irrational
            \ Integer Bool Signed Unsigned Int BigInt Int16 Int32 Int64 Int8 Int128 UInt128 UInt16 UInt32 UInt64 UInt8
            \ AbstractFloat BigFloat Float16 Float32 Float64
            \ AbstractString AbstractChar String Char Symbol SubString SubstitutionString
            \ AbstractArray AbstractMatrix AbstractVector UndefInitializer
            \ AbstractUnitRange AbstractRange LinRange OrdinalRange StepRangeLen
            \ Array Matrix Vector VecOrMat UnitRange
            \ AbstractDict AbstractSet Dict Set Tuple NTuple NamedTuple Pair
            \ AbstractDateTime AbstractTime AbstractDateToken
            \ Date DateTime Time TimeZone TimeType TimeTypeOrPeriod DateFormat DateFunction DateLocale DatePart
            \ DatePeriod TimePeriod FixedPeriod GeneralPeriod OtherPeriod Instant Locale
            \ Calendar Year Quarter Month Week Day Hour Minute Second Millisecond Microsecond Nanosecond
            \ DayOfWeekToken Mon Monday Tue Tuesday Wed Wednesday Thu Thursday Fri Friday Sat Saturday Sun Sunday
            \ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dev
            \ January February March April May June July August September October November December

syn keyword juliaCustomType
            \ DataFrame
            \ TS AbstractTS
            \ Strategy Indicator Signal Rule ParameterSet Universe Portfolio Results

syn match juliaConstant  "\<[A-Z_]\{2,}\>\((\)\@!"
syn match juliaDelimiter ">\((\|;\)\@=\|\(\w\)\@<=<\|\[\|\]\|(\|)\|,\|{\|}\|;"
syn match juliaFunction  "\w*(\@=\|\w*\(!(\)\@="                               contains=juliaDelimiter
syn match juliaIndex     "\[.*\]"                                              contains=juliaEnd,juliaNumber,juliaVariable,juliaDelimiter,juliaOperator,juliaFunction,juliaConstant
syn match juliaMacro     "@\(\w\)\+"
syn match juliaNumber    "\<[0-9.]\+\>\|[0-9]e[0-9-]"
syn match juliaOperator  "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|::\|%\|\.\.\.\|\.\|<:\|>:\|\^"
syn match juliaSpecial   "[$@]\(\w\)+\|`"
syn match juliaSymbol    "[:<>0-9]\@<!:\(\w\)\+"
syn match juliaType      "\(::\|<:\|<:\s\)\@<=\<\w*\>\|\<\w*\>\@=\(<:\|\s<:\)" contains=juliaOperator

syn region juliaCharacter start=+'+  end=+'+  contains=juliaVariable
syn region juliaComment   start="#"  end="$"  contains=juliaTodo
syn region juliaComment   start="#=" end="=#" contains=juliaTodo
syn region juliaString    start=+"+  end=+"+  contains=juliaVariable

hi def link juliaBoolean      Boolean
hi def link juliaCharacter    Character
hi def link juliaComment      Comment
hi def link juliaConstant     Constant
hi def link juliaCustomModule PreProc
hi def link juliaCustomType   Type
hi def link juliaDelimiter    Delimiter
hi def link juliaEnd          Constant
hi def link juliaFunction     Operator
hi def link juliaKeyword      Keyword
hi def link juliaMacro        PreProc
hi def link juliaModule       PreProc
hi def link juliaNumber       Number
hi def link juliaOperator     Operator
hi def link juliaSpecial      SpecialChar
hi def link juliaStatement    Statement
hi def link juliaString       String
hi def link juliaSymbol       String
hi def link juliaTodo         Todo
hi def link juliaType         Type
hi def link juliaVariable     Identifier

let b:current_syntax = "julia"
