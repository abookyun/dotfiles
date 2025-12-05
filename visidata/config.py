# VisiData configuration for macOS
# Redirect to XDG config directory

import os
from pathlib import Path

# Use XDG_CONFIG_HOME instead of ~/Library/Preferences
xdg_config = Path(os.environ.get('XDG_CONFIG_HOME', Path.home() / '.config'))
vd_config_dir = xdg_config / 'visidata'

# Set VisiData directory to XDG location
options.visidata_dir = str(vd_config_dir)
