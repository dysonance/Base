syn keyword jsConstant
            \ null
            \ undefined
syn keyword jsKeyword
            \ continue
            \ var
            \ let
            \ for
            \ in
            \ if
            \ else
            \ return
            \ const
            \ function
syn keyword jsPreProc
            \ import
            \ export
            \ from
            \ require
syn keyword jsTodo contained
            \ TODO
            \ FIXME
            \ XXX
            \ NOTE
syn keyword jsBoolean
            \ true
            \ false

syn match jsConstant  "\<[A-Z_]\{2,}\>\((\)\@!"
syn match jsDelimiter "(\|)\|\[\|\]\|;\|,\|{\|}"
syn match jsFunction  "\w\+\s*(\@=\|\w\+<.*>\s*(\@="
syn match jsNumber    "\<[0-9.]\+\>\|[0-9]e[0-9-]\|\.\d\+\|\d\@<=\.[0-9 ]\@="
syn match jsOperator  "+\|-\|*\|/\|%\|=\|!\|:\|>\|<\|?\|[A-z]\@<=\.[A-z]\@=\|&&\|||"
syn match jsQuery     "\$"

" NOTE: these template regions must be defined before the string regions
" otherwise all non-template strings become template strings
syn region jsTemplateString start=+`+   end=+`+  contains=jsTemplate keepend extend
syn region jsTemplate       start="\""  end="\"" containedin=jsTemplateString
syn region jsTemplate       start="\${" end="}"  containedin=jsTemplateString

syn region jsComment start="//"   end="$"    contains=jsTodo
syn region jsComment start="\/\*" end="\*\/" contains=jsTodo
syn region jsString  start="\""   end="\""
syn region jsString  start="\'"   end="\'"

hi def link jsBoolean        Boolean
hi def link jsComment        Comment
hi def link jsConstant       Constant
hi def link jsDelimiter      Delimiter
hi def link jsFunction       Function
hi def link jsKeyword        Keyword
hi def link jsNumber         Number
hi def link jsOperator       Operator
hi def link jsPreProc        PreProc
hi def link jsQuery          Special
hi def link jsString         String
hi def link jsTemplate       Special
hi def link jsTemplateString String
hi def link jsTodo           Todo

let b:current_syntax = "javascript"
