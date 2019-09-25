scriptencoding utf-8

syn case match

syn keyword juliaTodo contained
            \ FIXME
            \ NOTE
            \ TODO

syn keyword juliaPreProc
            \ import
            \ using

syn keyword juliaStatement
            \ abstract
            \ begin
            \ break
            \ call
            \ catch
            \ continue
            \ do
            \ export
            \ finally
            \ function
            \ let
            \ mutable
            \ return
            \ struct
            \ try
            \ type

syn keyword juliaModule
            \ Base
            \ Base64
            \ Core
            \ Dates
            \ Distributed
            \ Future
            \ LinearAlgebra
            \ Pkg
            \ Printf
            \ REPL
            \ Random
            \ Statistics
            \ Test

syn keyword juliaCustomModule
            \ DataFrames
            \ DataStreams
            \ Distributions
            \ Documenter
            \ GR
            \ HTTP
            \ Indicators
            \ IterableTables
            \ Iterators
            \ JSON
            \ JuMP
            \ JuliaDB
            \ LibPQ
            \ MIDI
            \ MusicManipulations
            \ OhMyREPL
            \ Plots
            \ ProgressMeter
            \ Query
            \ RecipesBase
            \ Revise
            \ StatsKit
            \ Stochatto
            \ Strategems
            \ Temporal
            \ TimeSeries

syn keyword juliaKeyword
            \ abstract
            \ bitstype
            \ block
            \ catch
            \ const
            \ else
            \ elseif
            \ end
            \ finally
            \ for
            \ function
            \ global
            \ if
            \ in
            \ local
            \ macro
            \ module
            \ mutable
            \ quote
            \ struct
            \ try
            \ type
            \ typealias
            \ where
            \ while

syn keyword juliaBoolean
            \ false
            \ true

syn keyword juliaConstant
            \ NaN
            \ missing
            \ nothing
            \ pi
            \ stderr
            \ stdin
            \ stdout
            \ undef

syn keyword juliaEndIndex contained
            \ end

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
            \ AbstractTS
            \ Backtest
            \ DataFrame
            \ Indicator
            \ ParameterSet
            \ Portfolio
            \ Rule
            \ Signal
            \ Strategy
            \ TS
            \ Trade
            \ Universe

syn match juliaConstant  "\<[A-Z_]\{2,}\>\((\)\@!"
syn match juliaDelimiter ">\((\|;\)\@=\|\(\w\)\@<=<\|\[\|\]\|(\|)\|,\|{\|}\|;"
syn match juliaFormat    "\$\<\w*\>"                                           contained
syn match juliaFormat    "\\n\|\\t\|\$\<\w\+\>\|\(\$(.*\)\@<=\()\)"            containedin=juliaString,juliaCharacter
syn match juliaFunction  "\<\w*\>(\@=\|\<\w*\>\(!(\)\@=\|\<\w*\>\(.!(\)\@=\|\<\w*\>\(.(\)\@="
syn match juliaIndex     "\[.*\]"                                              contains=ALL
syn match juliaMacro     "@\(\w\)\+"
syn match juliaNumber    "\<[0-9_.]\+\>\|[0-9]e[0-9-]"
syn match juliaOperator  "+\|-\|*\|\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|?\|::\|%\|\.\.\.\|\.\|<:\|>:\|\^"
syn match juliaSpecial   "[$@]\(\w\)+\|`"
syn match juliaSymbol    "\([:<>0-9]\|\>\)\@<!:\<\w\+\>"
syn match juliaType      "\(::\|<:\|<:\s\)\@<=\<\w*\>\|\<\w*\>\@=\(<:\|\s<:\)" contains=juliaOperator
syn match juliaCharacter "'\w'\|'\\\w'"

syn region juliaComment   start="#"             end="$"                  contains=juliaTodo
syn region juliaComment   start="#="            end="=#"                 contains=juliaTodo extend
syn region juliaFormat    start="\$("           end="\(\$(.*\)\@<=\()\)" containedin=juliaString extend keepend
syn region juliaString    start="\""            end="\""                 contains=juliaFormat extend
syn region juliaString    start="\"\"\""        end="\"\"\""

hi def link juliaBoolean      Boolean
hi def link juliaCharacter    Character
hi def link juliaComment      Comment
hi def link juliaConstant     Constant
hi def link juliaCustomModule PreProc
hi def link juliaCustomType   Type
hi def link juliaDelimiter    Delimiter
hi def link juliaEndIndex     Constant
hi def link juliaFormat       SpecialChar
hi def link juliaFormatGroup  SpecialChar
hi def link juliaFormatStart  SpecialChar
hi def link juliaFunction     Function
hi def link juliaKeyword      Keyword
hi def link juliaMacro        PreProc
hi def link juliaModule       PreProc
hi def link juliaNumber       Number
hi def link juliaOperator     Operator
hi def link juliaPreProc      PreProc
hi def link juliaSpecial      SpecialChar
hi def link juliaStatement    Statement
hi def link juliaString       String
hi def link juliaSymbol       String
hi def link juliaTodo         Todo
hi def link juliaType         Type
hi def link juliaVariable     Identifier

let b:current_syntax = "julia"
