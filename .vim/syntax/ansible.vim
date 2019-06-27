syn keyword ansibleBoolean
            \ true
            \ false
            \ yes
            \ no

syn keyword ansibleInclude
            \ include_role
            \ import_role

syn keyword ansibleCommand
            \ ignore_errors
            \ include_role
            \ local_action

syn match ansibleDelimiter       "\[\|\]\|-\|{{\|}}\|:"
syn match ansibleStringDelimiter "\"\|\'"
syn match ansibleParameter       "\<\w\+\>\(:\)\@="
syn match ansibleGroup           "\(- \)\@<=\<\w\+\>\(:\)\@="
syn match ansiblePlay            "\(- name: \)\@<=.*" contains=ansibleStringDelimiter
syn match ansibleNumber          "\<[0-9.]\+\>\|[0-9]e[0-9-]"
syn match ansibleCommand         "\(command:\)\@<=.*" contains=ansibleStringDelimiter
syn match ansibleOperator        "!\||"
syn match ansibleError           "\t"

syn region ansibleComment start="#"  end="\n"
syn region ansibleString  start="\"" end="\"" contains=ansiblePlay keepend
syn region ansibleString  start="\'" end="\'" contains=ansiblePlay keepend

hi def link ansibleBoolean         Boolean
hi def link ansibleCommand         Statement
hi def link ansibleComment         Comment
hi def link ansibleDelimiter       Delimiter
hi def link ansibleError           Error
hi def link ansibleGroup           Keyword
hi def link ansibleInclude         PreProc
hi def link ansibleKeyword         Keyword
hi def link ansibleNumber          Number
hi def link ansibleOperator        Operator
hi def link ansibleParameter       Type
hi def link ansiblePlay            Function
hi def link ansibleString          String
hi def link ansibleStringDelimiter String

let b:current_syntax = "ansible"
