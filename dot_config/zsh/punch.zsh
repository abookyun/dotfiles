# Terminal-side integration for punch (timewarrior wrapper).
#
# The failure mode this exists to fix is forgetting to start tracking, so the
# hint has to appear where the eye already is -- the prompt -- and it has to
# appear on every prompt, not only on cd. Opening a new tab straight into a
# project never fires chpwd, and that is exactly when tracking is forgotten.
#
# Nothing here starts or stops tracking. It only tells you the state is wrong;
# acting on it stays a deliberate keystroke.

# Bail out early if the wrapper is not installed, so this file is inert rather
# than broken on a machine that has not run `brew install timewarrior` yet.
(( $+commands[punch] )) || return 0

typeset -g PUNCH_HINT_ENABLED=1
typeset -g PUNCH_TITLE_ENABLED=1
# How long to stay quiet between nudges outside a project. 0 disables them.
typeset -g PUNCH_HINT_IDLE_MINUTES=30
[[ -r ${XDG_CONFIG_HOME:-$HOME/.config}/punch/config ]] \
  && source ${XDG_CONFIG_HOME:-$HOME/.config}/punch/config

# EPOCHSECONDS, for throttling without spawning date(1) on every prompt.
zmodload -F zsh/datetime +p:EPOCHSECONDS 2>/dev/null

# Remember what we last complained about, so the hint appears on entering a
# mismatched state instead of nagging on every prompt for the same state.
typeset -g _punch_last_hint=""
typeset -g _punch_last_nudge=0

# The prompt runs this on every command, so it resolves both halves of the
# state in a single `punch` call rather than spawning one process per field.
_punch_state() {
  typeset -g _punch_project _punch_active _punch_elapsed
  local line
  line=$(punch prompt-state 2>/dev/null)
  _punch_project=${line%%$'\t'*}
  line=${line#*$'\t'}
  _punch_active=${line%%$'\t'*}
  _punch_elapsed=${line#*$'\t'}
}

_punch_hint() {
  (( PUNCH_HINT_ENABLED )) || return 0

  # State-change dedupe, so a steady state is stated once rather than on every
  # prompt. The no-project case opts out: it is throttled by elapsed time
  # instead, and its key never changes, which would silence it permanently.
  local key="${_punch_project}:${_punch_active}"
  if [[ -n $_punch_project || -n $_punch_active ]]; then
    [[ $key == $_punch_last_hint ]] && return 0
  fi
  _punch_last_hint=$key

  # In a project directory with nothing running: the case that loses time.
  if [[ -n $_punch_project && -z $_punch_active ]]; then
    print -P "%F{yellow}⏱%f ${_punch_project} %F{242}not clocked in — %f%F{yellow}punch in%f"
    return 0
  fi

  # Tracking something other than where you are: time is being misattributed.
  if [[ -n $_punch_project && -n $_punch_active && $_punch_project != $_punch_active ]]; then
    print -P "%F{yellow}⏱%f clocked into %F{red}${_punch_active}%f but sitting in %F{green}${_punch_project}%f %F{242}— %f%F{yellow}punch in%f"
    return 0
  fi

  # Clocked out with no project in sight -- a meeting, internal docs, errands.
  # That time is still work and is the hardest to reconstruct afterwards, but
  # a directory without a project is also where you idly open a terminal, so
  # this one is throttled by the clock instead of firing on every prompt.
  if [[ -z $_punch_project && -z $_punch_active ]]; then
    local now=$EPOCHSECONDS
    local quiet=$(( PUNCH_HINT_IDLE_MINUTES * 60 ))
    (( quiet <= 0 )) && return 0
    if (( now - _punch_last_nudge >= quiet )); then
      _punch_last_nudge=$now
      print -P "%F{242}⏸ not clocked in — %f%F{yellow}punch in <what>%f"
    fi
  fi
}

# Terminal window/tab title. In a bare Ghostty window with no tmux and no
# status line, this is the only indicator visible from outside the terminal,
# so it carries the state when the prompt has scrolled away.
_punch_title() {
  (( PUNCH_TITLE_ENABLED )) || return 0

  local label
  if [[ -n $_punch_active ]]; then
    label="⏱ ${_punch_active} ${_punch_elapsed}"
  elif [[ -n $_punch_project ]]; then
    label="⏸ ${_punch_project}"
  else
    label=${PWD:t}
  fi

  # OSC 2 sets the window title; Ghostty mirrors it onto the tab.
  printf '\e]2;%s\a' $label
}

autoload -Uz add-zsh-hook

_punch_precmd() {
  _punch_state
  _punch_hint
  _punch_title
}
add-zsh-hook precmd _punch_precmd

# Reset the dedupe on cd so entering a project always speaks up, even if the
# previous directory happened to be in the same state.
_punch_chpwd() { _punch_last_hint="" }
add-zsh-hook chpwd _punch_chpwd
