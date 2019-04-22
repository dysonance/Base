syn case match
syn sync minlines=50

if has("spell")
  syn spell toplevel
endif

syn include @gitcommitDiff syntax/diff.vim
syn region gitcommitDiff start=/\%(^diff --\%(git\|cc\|combined\) \)\@=/ end=/^\%(diff --\|$\|#\)\@=/ fold contains=@gitcommitDiff

syn match  gitcommitFirstLine "\%^[^#].*"  nextgroup=gitcommitBlank
syn match  gitcommitSummary   "^.\{0,120\}" contained containedin=gitcommitFirstLine contains=@Spell
syn match  gitcommitBlank     "^[^#].*" contained contains=@Spell
syn match  gitcommitComment   "^#.*"
syn match  gitcommitHead      "^\%(#   .*\n\)\+#$" contained transparent
syn match  gitcommitOnBranch  "\%(^# \)\@<=On branch" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite
syn match  gitcommitOnBranch  "\%(^# \)\@<=Your branch .\{-\} '" contained containedin=gitcommitComment nextgroup=gitcommitBranch skipwhite
syn match  gitcommitBranch    "[^ ']\+" contained
syn match  gitcommitNoBranch  "\%(^# \)\@<=Not currently on any branch." contained containedin=gitcommitComment
syn match  gitcommitHeader    "\%(^# \)\@<=.*:$"  contained containedin=gitcommitComment
syn region gitcommitAuthor    matchgroup=gitCommitHeader start=/\%(^# \)\@<=\%(Author\|Committer\):/ end=/$/ keepend oneline contained containedin=gitcommitComment transparent
syn match  gitcommitNoChanges "\%(^# \)\@<=No changes$" contained containedin=gitcommitComment

syn region gitcommitUntracked     start=/^# Untracked files:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUntrackedFile fold
syn match  gitcommitUntrackedFile "\t\@<=.*"   contained

syn region gitcommitDiscarded start=/^# Change\%(s not staged for commit\|d but not updated\):/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitDiscardedType fold
syn region gitcommitSelected  start=/^# Changes to be committed:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitSelectedType fold
syn region gitcommitUnmerged  start=/^# Unmerged paths:/ end=/^#$\|^#\@!/ contains=gitcommitHeader,gitcommitHead,gitcommitUnmergedType fold

syn match gitcommitDiscardedType  "\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2 contained containedin=gitcommitComment nextgroup=gitcommitDiscardedFile skipwhite
syn match gitcommitSelectedType   "\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2 contained containedin=gitcommitComment nextgroup=gitcommitSelectedFile skipwhite
syn match gitcommitUnmergedType   "\t\@<=[[:lower:]][^:]*[[:lower:]]: "he=e-2 contained containedin=gitcommitComment nextgroup=gitcommitUnmergedFile skipwhite
syn match gitcommitDiscardedFile  ".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitDiscardedArrow
syn match gitcommitSelectedFile   ".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitSelectedArrow
syn match gitcommitUnmergedFile   ".\{-\}\%($\| -> \)\@=" contained nextgroup=gitcommitSelectedArrow
syn match gitcommitDiscardedArrow " -> " contained nextgroup=gitcommitDiscardedFile
syn match gitcommitSelectedArrow  " -> " contained nextgroup=gitcommitSelectedFile
syn match gitcommitUnmergedArrow  " -> " contained nextgroup=gitcommitSelectedFile

syn match gitcommitWarning "\%^[^#].*: needs merge$" nextgroup=gitcommitWarning skipnl
syn match gitcommitWarning "^[^#].*: needs merge$" nextgroup=gitcommitWarning skipnl contained
syn match gitcommitWarning "^\%(no changes added to commit\|nothing \%(added \)\=to commit\)\>.*\%$"

hi def link gitcommitSummary        Keyword
hi def link gitcommitComment        Comment
hi def link gitcommitUntracked      Comment
hi def link gitcommitDiscarded      Comment
hi def link gitcommitSelected       Comment
hi def link gitcommitUnmerged       Comment
hi def link gitcommitOnBranch       Comment
hi def link gitcommitBranch         Special
hi def link gitcommitNoBranch       Special
hi def link gitcommitDiscardedType  Type
hi def link gitcommitSelectedType   Type
hi def link gitcommitUnmergedType   Type
hi def link gitcommitType           Type
hi def link gitcommitNoChanges      PreProc
hi def link gitcommitHeader         PreProc
hi def link gitcommitUntrackedFile  Constant
hi def link gitcommitDiscardedFile  Constant
hi def link gitcommitSelectedFile   Constant
hi def link gitcommitUnmergedFile   Constant
hi def link gitcommitFile           Constant
hi def link gitcommitDiscardedArrow Comment
hi def link gitcommitSelectedArrow  Comment
hi def link gitcommitUnmergedArrow  Comment
hi def link gitcommitArrow          Comment
hi def link gitcommitBlank          Error

let b:current_syntax = "gitcommit"
