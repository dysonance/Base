# NOTE: this config file should generally be located:
# ~/.ipython/profile_default/ipython_config.py

import numpy as np
import pandas as pd

# np.core.arrayprint._line_width = 140
np.set_printoptions(linewidth=140)
pd.options.display.max_rows = 40
pd.set_option('display.max_rows', 40)

config = get_config()
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = 'vim'

c.InteractiveShellApp.exec_lines = [
    '%load_ext autoreload',
    '%autoreload 2',
    'import numpy as np',
    'import pandas as pd',
    'import datetime as dt',
    'from pylab import *',
    'ion()',
]
