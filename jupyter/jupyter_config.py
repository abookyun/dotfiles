# Jupyter configuration file

c = get_config()

# Notebook configuration
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8888
c.NotebookApp.ip = 'localhost'

# Security
c.NotebookApp.token = ''
c.NotebookApp.password = ''

# File management
c.FileContentsManager.delete_to_trash = True

# Kernel management
c.MappingKernelManager.default_kernel_name = 'python3'