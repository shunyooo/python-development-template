import os
import subprocess
import sys

import pandas as pd
from IPython import get_ipython
from tqdm.auto import tqdm

os.environ["MPLCONFIGDIR"] = "/tmp/matplotlib"


# -- pandas --
pd.set_option("display.max_colwidth", 500)
pd.set_option("display.max_rows", 1000)

# -- add path --

sys.path.append("../")

# -- tqdm --

tqdm.pandas(desc="Processing")

# -- magic command --

ipython = get_ipython()
if ipython:
    running_in_notebook = ipython.has_trait("kernel")
    if running_in_notebook:
        ipython.magic("reload_ext autoreload")
        ipython.magic("autoreload 2")
        ipython.magic("matplotlib inline")
else:
    # cannot even get ipython object...
    running_in_notebook = False
