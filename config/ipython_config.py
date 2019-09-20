# NOTE: this config file should generally be located:
# ~/.ipython/profile_default/ipython_config.py

import numpy as np
import pandas as pd
from IPython.terminal.prompts import Prompts, Token

np.set_printoptions(linewidth=140, suppress=True)
pd.options.display.max_rows = 40
pd.set_option("display.max_rows", 40)

config = get_config()
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.editor = "vim"

c.InteractiveShellApp.exec_lines = [
    "%load_ext autoreload",
    "%autoreload 2",
    "import os",
    "import numpy as np",
    "import pandas as pd",
    "import datetime as dt",
    "from pylab import *",
    "import matplotlib.pyplot as mpl",
    "ion()",
    'pd.set_option("display.width", 140)',
    'pd.set_option("display.max_columns", 500)',
]


class CustomPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        return [(Token.Prompt, ":> ")]

    def continuation_prompt_tokens(self, cli=None, width=None):
        return [(Token.Prompt, "   ")]

    def out_prompt_tokens(self):
        return [(Token.Prompt, "")]


c.TerminalInteractiveShell.prompts_class = CustomPrompt
c.TerminalInteractiveShell.colors = "linux"
c.TerminalInteractiveShell.editing_mode = "vi"
