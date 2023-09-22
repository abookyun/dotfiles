export RBENV_ROOT=$XDG_DATA_HOME/rbenv

RUBY_DATA_HOME=$XDG_DATA_HOME/ruby
RUBY_STATE_HOME=$XDG_STATE_HOME/ruby
if ! [ -d "$RUBY_DATA_HOME" ]; then mkdir -p $RUBY_DATA_HOME; fi
if ! [ -d "$RUBY_STATE_HOME" ]; then mkdir -p $RUBY_STATE_HOME; fi

export IRBRC=$XDG_CONFIG_HOME/ruby/irbrc
export PRYRC=$XDG_CONFIG_HOME/ruby/pryrc
export BUNDLE_USER_HOME=$RUBY_DATA_HOME/bundle

if (( $+commands[rbenv] )); then eval "$(rbenv init - zsh)"; fi
