# Directory Stack
setopt AUTO_PUSHD # push the current directory visited on the stack
setopt PUSHD_IGNORE_DUPS # do not store duplicates in the stack
setopt PUSHD_SILENT # do not print the directory stack after pushd or popd

# Completion
setopt LIST_PACKED
setopt COMPLETE_IN_WORD

setopt AUTO_LIST
setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST
setopt IGNORE_EOF

# History
setopt APPEND_HISTORY # adds history
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases
