syn keyword pythonStatement
            \ assert
            \ break
            \ continue
            \ def
            \ del
            \ from
            \ import
            \ pass
            \ raise
            \ return
            \ yield

syn keyword pythonControl
            \ elif
            \ else
            \ except
            \ finally
            \ for
            \ if
            \ in
            \ try
            \ while
            \ with

syn keyword pythonKeyword
            \ as
            \ async
            \ catch
            \ class
            \ cls
            \ global
            \ lambda
            \ local
            \ nonlocal
            \ self

syn keyword pythonBuiltin
            \ __name__
            \ __init__
            \ __dict__
            \ __getattribute__
            \ __setattr__
            \ __repr__
            \ __class__

syn keyword pythonConstant
            \ inf
            \ None
            \ nan NaN

syn keyword pythonBoolean
            \ False
            \ True

syn keyword pythonType
            \ AssertionError
            \ Exception
            \ ValueError
            \ bool
            \ bytes
            \ complex
            \ dict
            \ float
            \ frozenset
            \ function
            \ int
            \ list
            \ range
            \ set
            \ str
            \ tuple

syn keyword pythonCustomType
            \ DataFrame Series Index
            \ array ndarray
            \ vector matrix cube

syn keyword pythonCustomLibrary
            \ black
            \ bokeh
            \ boto3
            \ bs4 BeautifulSoup
            \ cvxpy cp
            \ gnupg
            \ ipdb
            \ matplotlib pyplot mpl plt
            \ nose
            \ numba
            \ numpy np
            \ pandas pd
            \ plotly
            \ psycopg2
            \ pylab
            \ quandl
            \ requests
            \ scipy
            \ seaborn sns
            \ sklearn
            \ talib

syn keyword pythonStandardLibrary
            \ __future__
            \ __main__
            \ _dummy_thread
            \ _thread
            \ abc
            \ aifc
            \ argparse
            \ ast
            \ asynchat
            \ asyncio
            \ asyncore
            \ atexit
            \ audioop
            \ base64
            \ bdb
            \ binascii
            \ binhex
            \ bisect
            \ builtins
            \ bz2
            \ calendar
            \ cgi
            \ cgitb
            \ chunk
            \ cmath
            \ cmd
            \ code
            \ codecs
            \ codeop
            \ collections
            \ collections.abc
            \ colorsys
            \ compileall
            \ concurrent.futures
            \ configparser
            \ contextlib
            \ contextvars
            \ copy
            \ copyreg
            \ crypt
            \ csv
            \ ctypes
            \ curses
            \ curses.ascii
            \ curses.panel
            \ curses.textpad
            \ dataclasses
            \ datetime dt
            \ dbm
            \ decimal
            \ difflib
            \ dis
            \ distutils
            \ doctest
            \ dummy_threading
            \ email
            \ ensurepip
            \ enum
            \ errno
            \ faulthandler
            \ fcntl
            \ filecmp
            \ fileinput
            \ fnmatch
            \ fractions
            \ ftplib
            \ functools
            \ gc
            \ getopt
            \ getpass
            \ gettext
            \ glob
            \ grp
            \ gzip
            \ hashlib
            \ heapq
            \ hmac
            \ html
            \ html.entities
            \ html.parser
            \ http
            \ http.client
            \ http.cookiejar
            \ http.cookies
            \ http.server
            \ imaplib
            \ imghdr
            \ imp
            \ importlib
            \ inspect
            \ io
            \ ipaddress
            \ itertools
            \ json
            \ keyword
            \ linecache
            \ locale
            \ logging log
            \ logging.config
            \ logging.handlers
            \ lzma
            \ macpath
            \ mailbox
            \ mailcap
            \ marshal
            \ math
            \ mimetypes
            \ mmap
            \ modulefinder
            \ msilib
            \ msvcrt
            \ multiprocessing
            \ netrc
            \ nis
            \ nntplib
            \ numbers
            \ operator
            \ optparse
            \ os
            \ os
            \ os.path
            \ ossaudiodev
            \ parser
            \ pathlib
            \ pdb
            \ pickle
            \ pickletools
            \ pipes
            \ pkgutil
            \ platform
            \ plistlib
            \ poplib
            \ posix
            \ pprint
            \ pty
            \ pwd
            \ py_compile
            \ pyclbr
            \ pydoc
            \ queue
            \ quopri
            \ random
            \ re
            \ readline
            \ reprlib
            \ resource
            \ rlcompleter
            \ runpy
            \ sched
            \ secrets
            \ selectors
            \ shelve
            \ shlex
            \ shutil
            \ signal
            \ site
            \ smtpd
            \ smtplib
            \ sndhdr
            \ socket
            \ socketserver
            \ spwd
            \ sqlite3
            \ ssl
            \ stat
            \ statistics
            \ string
            \ stringprep
            \ struct
            \ subprocess
            \ sunau
            \ symbol
            \ symtable
            \ sys
            \ sysconfig
            \ syslog
            \ tabnanny
            \ tarfile
            \ telnetlib
            \ tempfile
            \ termios
            \ test
            \ test.support
            \ test.support.script_helper
            \ textwrap
            \ threading
            \ time
            \ timeit
            \ tkinter
            \ tkinter.scrolledtext
            \ tkinter.tix
            \ tkinter.ttk
            \ token
            \ tokenize
            \ trace
            \ traceback
            \ tracemalloc
            \ tty
            \ turtle
            \ types
            \ typing
            \ unicodedata
            \ unittest
            \ unittest.mock
            \ unittest.mock
            \ urllib
            \ urllib.error
            \ urllib.parse
            \ urllib.request
            \ urllib.response
            \ urllib.robotparser
            \ uu
            \ uuid
            \ venv
            \ warnings
            \ wave
            \ weakref
            \ webbrowser
            \ winreg
            \ winsound
            \ wsgiref
            \ xdrlib
            \ xml.dom
            \ xml.dom.minidom
            \ xml.dom.pulldom
            \ xml.etree.ElementTree
            \ xml.parsers.expat
            \ xml.sax
            \ xml.sax.handler
            \ xml.sax.saxutils
            \ xml.sax.xmlreader
            \ xmlrpc
            \ xmlrpc.client
            \ xmlrpc.server
            \ zipapp
            \ zipfile
            \ zipimport
            \ zlib

syn match pythonIdentifier "\<\w\+\>"
syn match pythonConstant   "\<[A-Z_0-9]\{2,}\>\((\)\@!\|\<nan\>\|\<NaN\>\|\<NA\>"
syn match pythonDecorator  "@\@<=\w*\|@"
syn match pythonDelimiter  "\[\|\]\|(\|)\|,\|{\|}\|;"
syn match pythonFunction   "\w*(\@=\|\.\@<=\w*\["     contains=pythonDelimiter
syn match pythonNumber     "\<[0-9_.]\+\>\|[0-9_]\+e[0-9-]\+"
syn match pythonOperator   "+\|-\|*\|\/\|\/\/\(\/\)\@!\|->\|<\|>\|=\||\|&\|!\|:\|%\|\.\|\~\|\<is\>\|\<not\>\|\<or\>\|\<and\>"
syn match pythonTodo       "TODO\|FIXME\|NOTE"
syn match pythonCustomType "\(pd\.\)\@<=[A-Z].\w\+Index\|\(\<dt\>\.\)\@<=\(\<date\>\|\<datetime\>\|\<timedelta\>\|time\)"
syn match pythonFormat     "\({}\)" contained containedin=pythonFormattedString

syn region pythonFormat          start="{"      end="}"      contained containedin=pythonFormattedString keepend
syn region pythonComment         start="#"      end="\n"     contains=pythonTodo
syn region pythonString          start="\"\"\"" end="\"\"\""
syn region pythonString          start=+"+      end=+"+
syn region pythonString          start=+'+      end=+'+
syn region pythonFormattedString start=+f"+     end=+"+
syn region pythonFormattedString start=+f'+     end=+'+

hi def link pythonBoolean         Boolean
hi def link pythonBuiltin         Special
hi def link pythonComment         Comment
hi def link pythonConstant        Constant
hi def link pythonControl         Statement
hi def link pythonCustomLibrary   PreProc
hi def link pythonCustomType      Type
hi def link pythonDecorator       PreProc
hi def link pythonFormat          SpecialChar
hi def link pythonDelimiter       Delimiter
hi def link pythonFunction        Operator
hi def link pythonKeyword         Keyword
hi def link pythonLibrary         PreProc
hi def link pythonNumber          Number
hi def link pythonOperator        Operator
hi def link pythonStandardLibrary PreProc
hi def link pythonStatement       Statement
hi def link pythonString          String
hi def link pythonFormattedString String
hi def link pythonTodo            Todo
hi def link pythonType            Type

highlight pythonFormat ctermfg=DarkGreen ctermbg=none

call TextEnableCodeSnip('sql', 'query.=.\"\{3\}', '\"\{3\}', 'SqlQuery')
call TextEnableCodeSnip('sql', 'query.=.\"\(\"\)\@!', '\"', 'SqlQuery')
highlight SqlQuery ctermfg=3 ctermbg=8
"highlight textSnipSQL ctermfg=none ctermbg=8

let b:current_syntax = "python"
