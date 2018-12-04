if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" All non-contained SQL syntax.
syn cluster sqlALL          contains=TOP

" Various error conditions.
syn match   sqlError        ")"                 " Lonely closing paren.
syn match   sqlError        ",\(\_\s*[;)]\)\@=" " Comma before a paren or semicolon.
syn match   sqlError        " $"                " Space at the end of a line.
" Comma before certain words.
syn match   sqlError        ",\_\s*\(\<\(asc\|desc\|exists\|for\|from\)\>\)\@="
syn match   sqlError        ",\_\s*\(\<\(group by\|into\|limit\|order\)\>\)\@="
syn match   sqlError        ",\_\s*\(\<\(table\|using\|where\)\>\)\@="

" Special words.
syn keyword sqlSpecial      false null true

" Keywords
syn keyword sqlKeyword      access add after aggregate as asc authorization
syn keyword sqlKeyword      begin by cache cascade check cluster collate
syn keyword sqlKeyword      collation column compress conflict connect connection
syn keyword sqlKeyword      constraint current cursor database debug decimal
syn keyword sqlKeyword      default desc each else elsif escape exception
syn keyword sqlKeyword      exclusive explain external file for foreign from function
syn keyword sqlKeyword      group having identified if immediate increment index
syn keyword sqlKeyword      initial inner into is join key left level loop
syn keyword sqlKeyword      maxextents mode modify nocompress nowait object of
syn keyword sqlKeyword      off offline on online option order outer pctfree full
syn keyword sqlKeyword      primary privileges procedure public references
syn keyword sqlKeyword      referencing release resource role row rowid
syn keyword sqlKeyword      rowlabel rownum rows schema session share size
syn keyword sqlKeyword      start successful synonym then to transaction trigger
syn keyword sqlKeyword      uid user using validate values view virtual whenever
syn keyword sqlKeyword      where with
syn match   sqlKeyword      "\<prompt\>"
syn match   sqlKeyword      "\<glob\>"
" Do special things with CREATE TABLE ( below.
syn match   sqlKeyword      "\<table\>"

" Operators
syn keyword sqlOperator     all any between case distinct elif else end
syn keyword sqlOperator     exit exists if in intersect is like match matches
syn keyword sqlOperator     minus out prior regexp some then union
syn keyword sqlOperator     unique when
syn keyword sqlOperator     and or is not
syn match   sqlOperator     "||\|:=\|!=\|*\|/\|::\|+\|-\|="

" Conditionals
syn match   sqlConditional  "=\|<\|>\|\<and\>\|\<or\>\|\<is\>\|\<not\>"

" Functions - Only valid with a '(' after them.
syn match sqlFunction "\<\(abs\|acos\|asin\|atan2\?\|avg\|cardinality\)(\@="
syn match sqlFunction "\<\(cast\|changes\|char_length\|character_length\)(\@="
syn match sqlFunction "\<\(coalesce\|concat\|cos\|count\|\(date\)\?\(time\)\?\)(\@="
syn match sqlFunction "\<\(exp\|filetoblob\|filetoclob\|floor\|glob\|group_concat\)(\@="
syn match sqlFunction "\<\(hex\|ifnull\|initcap\|isnull\|julianday\|last_insert_rowid\)(\@="
syn match sqlFunction "\<\(length\|log10\|logn\|lower\|lpad\|ltrin\|max\|min\)(\@="
syn match sqlFunction "\<\(mod\|nullif\|octet_length\|pow\|quote\|random\)(\@="
syn match sqlFunction "\<\(range\|replace\|root\|round\|rpad\|sin\|soundex\)(\@="
syn match sqlFunction "\<\(sqrtstdev\|strftime\|substr\|substring\|sum\|sysdate\|tan\)(\@="
syn match sqlFunction "\<\(to_char\|to_date\|to_number\|total\|trim\|trunc\|typeof\)(\@="
syn match sqlFunction "\<\(upper\|variance\)(\@="

" Statements
syn keyword sqlStatement    alter analyze audit begin comment commit delete set returning
syn keyword sqlStatement    drop execute explain grant insert lock noaudit
syn keyword sqlStatement    rename revoke rollback savepoint select
syn keyword sqlStatement    desc as limit
syn keyword sqlStatement    truncate update vacuum
syn keyword sqlStatement    with from group order by where
syn match   sqlStatement    "\<\(replace\|create\)\>"

" Types - Only matched inside 'CREATE TABLE ();'.
syn keyword sqlType bigint     bit blob bool boolean byte char
syn keyword sqlType clob       datetime dec decimal enum
syn keyword sqlType float      int int8 integer interval long
syn keyword sqlType longblob   longtext lvarchar mediumblob
syn keyword sqlType mediumint  mediumtext mlslabel money
syn keyword sqlType multiset   nchar number numeric nvarchar
syn keyword sqlType raw        real rowid serial serial8
syn keyword sqlType smallfloat smallint text time
syn keyword sqlType timestamp  tinyblob tinyint tinytext
syn keyword sqlType varchar    varchar2 varray year
syn match   sqlType contained  "\<\(character\|double\|varying\)\>"
syn match   sqlType contained  "\<character\s\+varying\>"
syn match   sqlType contained  "\<double\s\+precision\>"
syn match   sqlType "[\._\< as\>]\@<!date"
syn match   sqlType "[\._\< as\>]\@<!return"

" Strings
syn region sqlString        start=+"+  skip=+\\\\\|\\"+  end=+"+ contains=sqlVariable
syn region sqlString        start=+'+  skip=+\\\\\|\\'+  end=+'+ contains=sqlVariable
syn region sqlString        start=+`+  skip=+\\\\\|\\`+  end=+`+ contains=sqlVariable

" Numbers
syn match sqlNumber         "-\=\<[0-9]*\>"
syn match sqlNumber         "-\=\<[0-9]*\.[0-9]*\>"
syn match sqlNumber         "-\=\<[0-9][0-9]*e[+-]\=[0-9]*\>"
syn match sqlNumber         "-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>"
syn match sqlNumber         "\<0x[abcdef0-9]*\>"

" Todo
syn keyword sqlTodo         contained DEBUG FIXME NOTE TODO XXX

" Comments
syn region sqlComment       start="/\*"  end="\*/" contains=sqlTodo
syn match  sqlComment       "--.*$" contains=sqlTodo
syn match  sqlComment       "\(^\|\s\)rem.*$" contains=sqlTodo

" Delimiters
syn match sqlDelimiter ";\|(\|)\|,\|\."

" Stolen from sh.vim.
if !exists("sh_minlines")
  let sh_minlines = 200
endif
if !exists("sh_maxlines")
  let sh_maxlines = 2 * sh_minlines
endif
exec "syn sync minlines=" . sh_minlines . " maxlines=" . sh_maxlines


hi def link sqlComment       Comment
hi def link sqlError         Error
hi def link sqlFunction      Function
hi def link sqlUnknownFunc   Exception
hi def link sqlKeyword       Special
hi def link sqlNumber        Number
hi def link sqlDelimiter     Delimiter
hi def link sqlConditional   Operator
hi def link sqlOperator      Operator
hi def link sqlSpecial       Keyword
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
