# punch

A thin wrapper around [timewarrior](https://timewarrior.net/), shaped like a
punch clock.

timewarrior already models time the way this workflow needs: one timeline, one
active interval, punching in somewhere punches you out of everywhere else.
Switching between three projects in an afternoon records three intervals
totalling that afternoon, not three afternoons. What it does not know is
*which* project a directory belongs to, or what an hour of it is worth.
That gap is all `punch` fills.

## Commands

```
punch in [project] [tags...]   clock in (project defaults to $PWD's)
punch out                      clock out
punch status [short]           one-line state
punch init [name]              mark $PWD as a project (writes .punch-card)
punch bill [--month YYYY-MM] [--project X] [--csv|--markdown]
```

`start`/`stop` are synonyms for `in`/`out`. Aliases: `pi`, `po`, `pst`.

Anything else falls through to timewarrior, so its own vocabulary stays
available — which matters most for fixing mistakes after the fact:

```
punch summary :week            reports
punch move @2 09:00            shift an interval
punch @3 tag billable          retag
punch track 9:00 - 12:00 acme  backfill a session you forgot entirely
```

## How a project is decided

In order, most deliberate first:

1. A `.punch-card` file in the directory or any parent, containing the name
2. The `origin` remote's repository name
3. The directory name

Directories listed in `PUNCH_IGNORE_PATHS` never resolve to a project.
Non-ASCII names are preserved, so Chinese project names work as tags.

## Not forgetting

The reason this exists is that manual tracking fails at exactly two moments.

**Forgetting to clock in** loses time that is hard to reconstruct later. A
`precmd` hook prints one line whenever you are standing in a project with
nothing running, or clocked into a project other than the one you are in. It
runs on every prompt, not just on `cd` — opening a tab straight into a project
never fires `chpwd`, and that is exactly when clocking in gets forgotten. It
never clocks in for you; that stays a deliberate keystroke.

The terminal window title carries the same state, which is the only indicator
visible from outside a bare terminal with no status line.

**Forgetting to clock out** is worse, because the hours keep accruing to
whatever was last worked on. A launchd agent checks every minute and closes
out intervals once the machine has been idle past the threshold, ending the
interval where the activity ended rather than where the check ran. Idle longer
than the interval itself means nothing real happened, so it is discarded.
A max-hours cap catches machines left running overnight.

## Billing

Rates go in `config` as `PUNCH_RATE_<PROJECT>`, uppercased with
non-alphanumerics turned into `_` (project `client-a` → `PUNCH_RATE_CLIENT_A`).
Projects without a rate are reported with no amount rather than a zero, so
unbilled work stays visible.

```sh
punch bill -m 8                 # this year's August, table
punch bill -m 8 --csv | vd -    # straight into visidata
punch bill -m 2026-08 --markdown
```

## Switches

Everything is opt-out from `config`; the environment overrides the file for a
single run.

| Setting | Default | Effect |
| --- | --- | --- |
| `PUNCH_HINT_ENABLED` | 1 | prompt hints |
| `PUNCH_TITLE_ENABLED` | 1 | window title |
| `PUNCH_TMUX_ENABLED` | 1 | tmux status module |
| `PUNCH_IDLE_ENABLED` | 1 | automatic clock-out |
| `PUNCH_IDLE_MINUTES` | 15 | idle before clocking out |
| `PUNCH_MAX_INTERVAL_HOURS` | 12 | interval length treated as a forgotten punch-out |
| `PUNCH_IGNORE_PATHS` | — | colon-separated path prefixes that are never projects |

## What it installs

| Path | What |
| --- | --- |
| `~/.local/bin/punch` | the command |
| `~/.config/punch/config` | settings |
| `~/.config/zsh/punch.zsh` | prompt hooks, sourced from `.zshrc` |
| `~/.config/tmux/custom/punch.conf` | catppuccin status module |
| `~/Library/LaunchAgents/local.punch.idle.plist` | the idle agent |
| `~/.local/state/punch/idle.log` | agent output |
| `~/.local/share/timewarrior/` | the data, owned by timewarrior |

Each feature is a separate commit, so any one of them can be reverted alone.

## Removing it

```sh
launchctl unload ~/Library/LaunchAgents/local.punch.idle.plist
rm ~/Library/LaunchAgents/local.punch.idle.plist
rm -rf ~/.local/bin/punch ~/.config/punch ~/.config/zsh/punch.zsh \
       ~/.config/tmux/custom/punch.conf ~/.local/state/punch
# then drop the `source ${ZDOTDIR}/punch.zsh` line from .zshrc
```

The tracked data outlives the wrapper: `~/.local/share/timewarrior/` is
timewarrior's own plain-text database, readable and editable without any of
this.

## Known gaps

- The tmux status module is unverified. `#()` returned empty in every test
  harness reachable without an interactive client, and a `PATH` problem in the
  tmux server could not be told apart from a test method that cannot observe
  the status bar.
- Genuinely parallel work is not expressible. timewarrior has one active
  interval by design, which suits switching between projects and not running
  two at once.
