# IPython configuration file

# Configuration for IPython.InteractiveShell
c = get_config()

# Enable autoindent
c.InteractiveShell.autoindent = True

# Enable magic commands
c.InteractiveShell.automagic = True

# Auto-completion
c.IPCompleter.greedy = True

# History
c.HistoryManager.hist_file = ':memory:'  # Will be overridden by IPYTHON_DIR

# Terminal interface
c.TerminalInteractiveShell.highlighting_style = 'default'
c.TerminalInteractiveShell.true_color = True

# Prompts
c.TerminalInteractiveShell.prompts_class = 'IPython.terminal.prompts.ClassicPrompts'