syn match rustDelimiter "{\|}\|(\|)\|\[\|\]\|;\|,\|:"
hi def link rustDelimiter Delimiter

syn keyword rustKeyword
            \ async
hi def link rustKeyword Keyword
