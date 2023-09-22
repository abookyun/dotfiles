export RBENV_ROOT=$XDG_DATA_HOME/rbenv

RUBY_CONFIG_HOME=$XDG_CONFIG_HOME/ruby
RUBY_DATA_HOME=$XDG_DATA_HOME/ruby
if ! [ -d "$RUBY_CONFIG_HOME" ]; then mkdir -p $RUBY_CONFIG_HOME; fi
if ! [ -d "$RUBY_DATA_HOME" ]; then mkdir -p $RUBY_DATA_HOME; fi

export IRBRC=$RUBY_CONFIG_HOME/irbrc
export PRYRC=$RUBY_CONFIG_HOME/pryrc
export BUNDLE_USER_HOME=$RUBY_DATA_HOME/bundle

if (( $+commands[rbenv] )); then eval "$(rbenv init - zsh)"; fi
