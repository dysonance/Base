syn case ignore

syn keyword sqlTodo contained
            \ DEBUG
            \ FIXME
            \ NOTE
            \ TODO
            \ XXX

syn keyword sqlBoolean
            \ false
            \ true

syn keyword sqlConstant
            \ null

syn keyword sqlKeyword
            \ abort
            \ aggregate
            \ as
            \ asc
            \ begin
            \ by
            \ cascade
            \ column
            \ conflict
            \ constraint
            \ cross
            \ database
            \ default
            \ desc
            \ each
            \ else
            \ explain
            \ external
            \ file
            \ for
            \ foreign
            \ from
            \ full
            \ group
            \ having
            \ if
            \ index
            \ inner
            \ is
            \ join
            \ key
            \ left
            \ limit
            \ loop
            \ modify
            \ of
            \ on
            \ option
            \ order
            \ outer
            \ primary
            \ privileges
            \ procedure
            \ public
            \ references
            \ referencing
            \ right
            \ role
            \ row
            \ schema
            \ select
            \ session
            \ size
            \ table
            \ then
            \ to
            \ transaction
            \ trigger
            \ user
            \ using
            \ values
            \ view
            \ where
            \ with

syn keyword sqlStatement
            \ add
            \ alter
            \ analyze
            \ audit
            \ begin
            \ comment
            \ commit
            \ create
            \ declare
            \ delete
            \ drop
            \ execute
            \ explain
            \ grant
            \ insert
            \ into
            \ lock
            \ noaudit
            \ refresh
            \ rename
            \ replace
            \ returning
            \ returns
            \ revoke
            \ rollback
            \ savepoint
            \ set
            \ truncate
            \ update
            \ vacuum
            \ with

syn keyword sqlOperator
            \ all
            \ and
            \ any
            \ as
            \ between
            \ case
            \ desc
            \ distinct
            \ elif
            \ else
            \ end
            \ except
            \ exists
            \ exit
            \ if
            \ ilike
            \ in
            \ intersect
            \ is
            \ like
            \ match
            \ matches
            \ minus
            \ not
            \ or
            \ out
            \ prior
            \ regexp
            \ some
            \ then
            \ union
            \ unique
            \ when

syn keyword sqlType
            \ bool
            \ boolean
            \ char character
            \ datetime
            \ decimal
            \ double
            \ enum
            \ float
            \ function
            \ int
            \ integer
            \ long
            \ materialized
            \ number
            \ numeric
            \ precision
            \ real
            \ text
            \ time
            \ timestamp
            \ varchar varying
            \ view

syn keyword sqlFunction
            \ sum
            \ abs
            \ count

syn keyword sqlSpecial
            \ language
            \ plpgsql

syn match sqlType      "\(\.\)\@<!\(\<[Dd]ate\>\)"
syn match sqlOperator  "||\|:=\|!=\|*\|/\|::\|+\|-\|=\|<\|>\|\*\|\."
syn match sqlBoolean   "\'t'\|'f'"
syn match sqlNumber    "\<[0-9.]\+\>\|[0-9]e[0-9-]"
syn match sqlDelimiter ";\|(\|)\|,"
syn match sqlFunction  "\w\+\s*(\@=\|\w\+<.*>\s*(\@="
syn match sqlSpecial   "\$\|\(\$\$\)\|\(\$\w\)"
syn match sqlParameter "%s\|?"

syn region sqlString  start=+"+  end=+"+
syn region sqlString  start=+'+  end=+'+ contains=sqlBoolean keepend
syn region sqlComment start=+--+ end=+$+ contains=sqlTodo

hi def link sqlComment     Comment
hi def link sqlFunction    Function
hi def link sqlKeyword     Keyword
hi def link sqlNumber      Number
hi def link sqlDelimiter   Delimiter
hi def link sqlConditional Conditional
hi def link sqlOperator    Operator
hi def link sqlSpecial     Special
hi def link sqlBoolean     Boolean
hi def link sqlConstant    Constant
hi def link sqlStatement   Statement
hi def link sqlString      String
hi def link sqlTodo        Todo
hi def link sqlType        Type
hi def link sqlParameter   Constant

let b:current_syntax = "sql"
