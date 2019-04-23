syn case ignore

syn keyword sqlTodo contained
            \ DEBUG
            \ FIXME
            \ NOTE
            \ TODO
            \ XXX

syn keyword sqlSpecial
            \ false
            \ null
            \ true
            \ sql

syn keyword sqlKeyword
            \ access
            \ add
            \ after
            \ aggregate
            \ as
            \ asc
            \ authorization
            \ begin
            \ by
            \ cache
            \ cascade
            \ check
            \ cluster
            \ collate
            \ collation
            \ column
            \ compress
            \ conflict
            \ connect
            \ connection
            \ constraint
            \ cross
            \ current
            \ cursor
            \ database
            \ debug
            \ decimal
            \ default
            \ desc
            \ each
            \ else
            \ elsif
            \ escape
            \ exception
            \ exclusive
            \ explain
            \ external
            \ file
            \ for
            \ foreign
            \ from
            \ full
            \ glob
            \ group
            \ having
            \ identified
            \ if
            \ immediate
            \ increment
            \ index
            \ initial
            \ inner
            \ into
            \ is
            \ join
            \ key
            \ left
            \ level
            \ loop
            \ maxextents
            \ mode
            \ modify
            \ nocompress
            \ nowait
            \ object
            \ of
            \ off
            \ offline
            \ on
            \ online
            \ option
            \ order
            \ outer
            \ pctfree
            \ primary
            \ privileges
            \ procedure
            \ prompt
            \ public
            \ references
            \ referencing
            \ release
            \ resource
            \ right
            \ role
            \ row
            \ rowid
            \ rowlabel
            \ rownum
            \ rows
            \ schema
            \ session
            \ share
            \ size
            \ start
            \ successful
            \ synonym
            \ table
            \ then
            \ to
            \ transaction
            \ trigger
            \ uid
            \ user
            \ using
            \ validate
            \ values
            \ view
            \ virtual
            \ whenever
            \ where
            \ with

syn keyword sqlStatement
            \ alter
            \ analyze
            \ as
            \ audit
            \ begin
            \ by
            \ comment
            \ commit
            \ create
            \ delete
            \ desc
            \ drop
            \ execute
            \ explain
            \ from
            \ grant
            \ group
            \ insert
            \ limit
            \ lock
            \ noaudit
            \ order
            \ rename
            \ replace
            \ returning
            \ returns
            \ revoke
            \ rollback
            \ savepoint
            \ select
            \ set
            \ truncate
            \ update
            \ vacuum
            \ where
            \ with

syn keyword sqlOperator
            \ all
            \ and
            \ any
            \ between
            \ case
            \ distinct
            \ elif
            \ else
            \ end
            \ exists
            \ exit
            \ if
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
            \ bigint
            \ bit
            \ blob
            \ bool
            \ boolean
            \ byte
            \ char
            \ clob
            \ datetime
            \ dec
            \ decimal
            \ double
            \ enum
            \ float
            \ function
            \ int
            \ int8
            \ integer
            \ interval
            \ language
            \ long
            \ longblob
            \ longtext
            \ lvarchar
            \ mediumblob
            \ mediumint
            \ mediumtext
            \ mlslabel
            \ money
            \ multiset
            \ nchar
            \ number
            \ numeric
            \ nvarchar
            \ precision
            \ raw
            \ real
            \ rowid
            \ serial
            \ serial8
            \ smallfloat
            \ smallint
            \ text
            \ time
            \ timestamp
            \ tinyblob
            \ tinyint
            \ tinytext
            \ varchar
            \ varchar2
            \ varray
            \ year

syn match sqlOperator    "||\|:=\|!=\|*\|/\|::\|+\|-\|="
syn match sqlConditional "=\|<\|>\|\<and\>\|\<or\>\|\<is\>\|\<not\>"
syn match sqlNumber      "-\=\<[0-9]*\>\|-\=\<[0-9]*\.[0-9]*\>\|-\=\<[0-9][0-9]*e[+-]\=[0-9]*\>\|-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>\|\<0x[abcdef0-9]*\>"
syn match sqlError       ")\|,\(\_\s*[;)]\)\@=\| $\|,\_\s*\(\<\(asc\|desc\|exists\|for\|from\)\>\)\@=\|,\_\s*\(\<\(group by\|into\|limit\|order\)\>\)\@=\|,\_\s*\(\<\(table\|using\|where\)\>\)\@="
syn match sqlDelimiter   ";\|(\|)\|,\|\."
syn match sqlFunction    "\<\(abs\|acos\|asin\|atan2\?\|avg\|cardinality\|cast\|changes\|char_length\|character_length\|coalesce\|concat\|cos\|count\|\(date\)\?\(time\)\?\|exp\|filetoblob\|filetoclob\|floor\|glob\|group_concat\|hex\|ifnull\|initcap\|isnull\|julianday\|last_insert_rowid\|length\|log10\|logn\|lower\|lpad\|ltrin\|max\|min\|mod\|nullif\|octet_length\|pow\|quote\|random\|range\|replace\|root\|round\|rpad\|sin\|soundex\|sqrtstdev\|strftime\|substr\|substring\|sum\|sysdate\|tan\|to_char\|to_date\|to_number\|total\|trim\|trunc\|typeof\|upper\|variance\)(\@=\|\(function \)\@<=\<\w\+\>"
syn match sqlSpecial     "\$\|\(\$\$\)\|\(\$\w\)"

syn match sqlComment "--.*$"           contains=sqlTodo
syn match sqlComment "\(^\|\s\)rem.*$" contains=sqlTodo

syn region sqlString  start=+"+   skip=+\\\\\|\\"+ end=+"+   contains=sqlVariable
syn region sqlString  start=+'+   skip=+\\\\\|\\'+ end=+'+   contains=sqlVariable
syn region sqlString  start=+`+   skip=+\\\\\|\\`+ end=+`+   contains=sqlVariable
syn region sqlComment start="/\*"                  end="\*/" contains=sqlTodo

hi def link sqlComment       Comment
hi def link sqlError         Error
hi def link sqlFunction      Function
hi def link sqlUnknownFunc   Exception
hi def link sqlKeyword       Special
hi def link sqlNumber        Number
hi def link sqlDelimiter     Delimiter
hi def link sqlConditional   Operator
hi def link sqlOperator      Operator
hi def link sqlSpecial       PreProc
hi def link sqlStatement     Statement
hi def link sqlString        String
hi def link sqlTodo          Todo
hi def link sqlType          Type
hi def link sqlVariable      Identifier
hi def link sqlAnyString     sqlString
hi def link sqlAnyVariable   sqlVariable
hi def link sqlSetOptions    Operator
hi def link sqlSetValues     Special

let b:current_syntax = "sql"
