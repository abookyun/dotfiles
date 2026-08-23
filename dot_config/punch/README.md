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

Work with no directory behind it — a meeting, internal docs, errands — still
gets a nudge, but a quieter one: a directory without a project is also where
you idly open a terminal, so that hint is throttled to once every
`PUNCH_HINT_IDLE_MINUTES` rather than fired on every prompt. Name that work
directly, and it records like anything else:

```sh
punch in 開會
punch in 內部文件
```

The terminal window title carries the same state, which is the only indicator
visible from outside a bare terminal with no status line.

**Forgetting to clock out** is worse, because the hours keep accruing to
whatever was last worked on. A launchd agent checks every minute and closes
out intervals once the machine has been idle past the threshold, ending the
interval where the activity ended rather than where the check ran. Idle longer
than the interval itself means nothing real happened, so it is discarded.
A max-hours cap catches machines left running overnight.

## Billing

Rates go in `~/.config/punch/rates`, which is deliberately untracked — `config`
is a symlink into the dotfiles repo, and hourly rates do not belong in version
control. Copy `rates.example` to start.

Two forms are read: `PUNCH_RATE_CLIENT_A=2000` for ASCII names, and
`punch_rate[內部工具]=800` keyed by the tag itself. Chinese names need the
second form — they cannot form a shell identifier, so every one of them would
otherwise collapse onto the same variable and silently share a rate.

Projects without a rate are reported with no amount rather than a zero, so
unbilled work stays visible.

The report splits on that: projects with a rate are **billable**, everything
else is **internal** — listed with hours but no amount, so time spent on
meetings and internal work stays visible without being priced. Each group is
sorted longest-first and subtotalled separately, and the grand total keeps
hours and money apart, because they do not cover the same rows.

```sh
punch bill -m 8                       # this year's August
punch bill -m 8 --csv | vd -          # into visidata; has a billable column
punch bill -m 8 -p client-a -d --markdown > invoice.md
```

`--detail` lists every interval — date, start, end, hours — rather than a
month's total, which is what an invoice usually has to be backed by.

## Switches

Everything is opt-out from `config`; the environment overrides the file for a
single run.

| Setting | Default | Effect |
| --- | --- | --- |
| `PUNCH_HINT_ENABLED` | 1 | prompt hints |
| `PUNCH_HINT_IDLE_MINUTES` | 30 | quiet between nudges outside a project; 0 disables |
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
