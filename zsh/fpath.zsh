# add each topic folder to fpath so that they can add functions and completion scripts
for topic_folder ($DOTFILES/*) if [ -d $topic_folder ]; then  fpath=($topic_folder $fpath); fi;

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -U $DOTFILES/functions/*(:t)
