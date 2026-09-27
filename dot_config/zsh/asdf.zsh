# asdf environment variables.
# asdf reads these from the environment, not from asdf/asdfrc. That file is
# key-value config and holds a different kind of setting.
#
# Keep this file to plain exports. The chezmoi install script sources it with
# bash, so zsh-only syntax such as setopt would break that script.

# asdf
export ASDF_CONFIG_FILE=${XDG_CONFIG_HOME}/asdf/asdfrc
export ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf

# asdf-nodejs: default npm packages
export ASDF_NPM_DEFAULT_PACKAGES_FILE=${XDG_CONFIG_HOME}/asdf/default-npm-packages

# asdf-python: default pip packages
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE=${XDG_CONFIG_HOME}/asdf/default-python-packages

# asdf-ruby: default gem packages
export ASDF_GEM_DEFAULT_PACKAGES_FILE=${XDG_CONFIG_HOME}/asdf/default-gems

# Where npm, pip and bundler keep their caches and config.
# `asdf install` runs these tools to install the default packages above, and it
# does not load the rest of the zsh config. They belong here so the install
# script and the interactive shell agree. Without them npm falls back to ~/.npm
# and pip to ~/Library/Caches/pip.
export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/config
export NPM_CONFIG_CACHE=${XDG_CACHE_HOME}/npm
export PIP_CACHE_DIR=${XDG_CACHE_HOME}/pip
export BUNDLE_USER_CONFIG=${XDG_CONFIG_HOME}/bundle
export BUNDLE_USER_CACHE=${XDG_CACHE_HOME}/bundle
export BUNDLE_USER_PLUGIN=${XDG_DATA_HOME}/bundle

# Compiler
# asdf install postgres needs pkg-config and icu4c. curl is here too, so keep
# both in one assignment: a second `export` would drop the first one.
# `opt/icu4c` is the unversioned symlink, so a new major version needs no edit
# here. Homebrew keeps one icu4c at a time, and asdf recompiles postgres
# against whatever is current.
#
# openssl is the other way round. Homebrew ships @3 and @4 side by side because
# their binary layouts differ, so a library built against @3 cannot load @4.
# The ruby and python that asdf builds link to @3, which is why the Brewfile
# names @3 and not the `openssl` alias: that alias moves to @4 one day, and a
# new machine would then build against the wrong one. Keep the number.
export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/icu4c/lib -L${HOMEBREW_PREFIX}/opt/curl/lib"
export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/icu4c/include -I${HOMEBREW_PREFIX}/opt/curl/include"
export PKG_CONFIG_PATH="${HOMEBREW_PREFIX}/opt/icu4c/lib/pkgconfig:${HOMEBREW_PREFIX}/opt/curl/lib/pkgconfig"
