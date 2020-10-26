syn keyword vueConstant
            \ null
            \ undefined

syn keyword vueKeyword
            \ const
            \ continue
            \ else
            \ for
            \ of
            \ function
            \ if
            \ in
            \ let
            \ new
            \ return
            \ this
            \ var
            \ import
            \ from
            \ export
            \ require

syn keyword vueTodo contained
            \ FIXME
            \ NOTE
            \ TODO
            \ XXX

syn keyword vueBoolean
            \ false
            \ true

syn keyword vueType
            \ Array
            \ Boolean
            \ Number
            \ Object
            \ String

syn keyword vueBuiltin
            \ components
            \ computed
            \ console
            \ data
            \ methods
            \ mounted
            \ name
            \ props

syn keyword vueModule
            \ Array
            \ Math
            \ String
            \ _

syn match vueConstant  "\<[A-Z_]\{2,}\>\((\)\@!"
syn match vueDelimiter "(\|)\|\[\|\]\|;\|,\|{\|}"
syn match vueFunction  "\w\+\s*(\@=\|\w\+<.*>\s*(\@="
syn match vueNumber    "\<[0-9.]\+\>\|[0-9]e[0-9-]\|\.\d\+\|\d\@<=\.[0-9 ]\@="
syn match vueOperator  "\.\|+\|-\|*\|/\|%\|=\|!\|:\|>\|<\|?\|[A-z]\@<=\.[A-z]\@=\|&&\|||"
syn match vueQuery     "\$"

" NOTE: these template regions must be defined before the string regions
" otherwise all non-template strings become template strings
syn region vueTemplateString start=+`+   end=+`+  contains=vueTemplate keepend extend
syn region vueTemplate       start="\""  end="\"" containedin=vueTemplateString
syn region vueTemplate       start="\${" end="}"  containedin=vueTemplateString

syn region vueComment start="//"   end="$"    contains=vueTodo
syn region vueComment start="\/\*" end="\*\/" contains=vueTodo
syn region vueString  start="\""   end="\""
syn region vueString  start="\'"   end="\'"

hi def link vueBoolean        Boolean
hi def link vueBuiltin        Special
hi def link vueComment        Comment
hi def link vueConstant       Constant
hi def link vueDelimiter      Delimiter
hi def link vueFunction       Function
hi def link vueKeyword        Keyword
hi def link vueNumber         Number
hi def link vueOperator       Operator
hi def link vueModule         PreProc
hi def link vuePreProc        PreProc
hi def link vueQuery          Special
hi def link vueString         String
hi def link vueTemplate       Special
hi def link vueTemplateString String
hi def link vueTodo           Todo
hi def link vueType           Type

function! TextEnableCodeSnip(filetype, start, end, textSnipHl) abort
    let ft=toupper(a:filetype)
    let group='textGroup'.ft
    if exists('b:current_syntax')
        let s:current_syntax=b:current_syntax
        " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
        " do nothing if b:current_syntax is defined.
        unlet b:current_syntax
    endif
    execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
    try
        execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
    catch
    endtry
    if exists('s:current_syntax')
        let b:current_syntax=s:current_syntax
    else
        unlet b:current_syntax
    endif
    execute 'syntax region textSnip'.ft.'
                \ matchgroup='.a:textSnipHl.'
                \ keepend
                \ start="'.a:start.'" end="'.a:end.'"
                \ contains=@'.group
endfunction
call TextEnableCodeSnip("html", "<template>", "<\/template>", 'SpecialComment')

let b:current_syntax="vue"

