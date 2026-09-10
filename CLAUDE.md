# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for macOS and Linux. The repo root mirrors `$HOME` — every file here gets symlinked into the real `$HOME` via GNU Stow, so `.config/zsh/.zshrc` here is `~/.config/zsh/.zshrc` at runtime. This working tree is the live config: `git checkout`, `git stash`, or `git reset --hard` here changes the running shell and Claude Code settings on the spot.

## Commands

```bash
# Install: symlink this repo's files into $HOME
stow -t "$HOME" .

# Uninstall: remove the symlinks
stow -t "$HOME" -D .

# Sync installed packages to the Brewfile (add/remove/upgrade/cleanup in one step)
# aliased as `bupc` once the dotfiles are stowed (config/zsh/config/aliases.zsh)
brew bundle check -v || brew bundle install -q
brew bundle cleanup -f
```

`brew bundle` needs no `--file` flag once the dotfiles are stowed: `.zprofile` sets `HOMEBREW_BUNDLE_FILE` per OS (`.config/brew/mac/Brewfile` on Darwin, `.config/brew/linux/Brewfile` on Linux). Add packages to the Brewfile and run `brew bundle` — not an ad hoc `brew install`.

No build step, linter, or test suite, and no CI. For `.zsh` files the only real check is to stow the change and watch the resulting shell behave. Two caveats if you reach for shellcheck or shfmt:

- `shellcheck` covers `.shellrc`, `.bashrc`, and the `.bash_*` files. It errors out with `SC1071` on every `.zsh` file (all of `.config/zsh/`, plus `.zprofile`, `.zshrc`, `.zlogin`, `.p10k.zsh`), so those have no lint coverage at all.
- `shfmt` defaults to tabs and every shell file here is space-indented. Use `shfmt -i 2 -d` to get a meaningful diff; a bare `shfmt -w` would retab the whole repo.

## Architecture

### What Stow skips

`.stow-local-ignore` keeps `scripts/`, `README*`, `.idea`, and this `CLAUDE.md` out of the symlink tree, so none of them ever land in `$HOME`.

### zsh startup order

Order matters here and is easy to break when editing:

1. `.zshenv` — the only zsh file that lives directly in `$HOME` (not symlinked from a subdirectory). Sets `ZDOTDIR="$HOME/.config/zsh"`, and for a non-login shell sources `.zprofile` from there itself.
2. `.zprofile` (`.config/zsh/.zprofile`): the env vars — locale, `TZ`, XDG paths, `DOTFILES_DIR`, plus an OS check (`uname`) that sets `HOMEBREW_PREFIX` and `HOMEBREW_BUNDLE_FILE` differently for Darwin vs Linux.
3. `.zshrc` (`.config/zsh/.zshrc`): sources `~/.shellrc` for utility functions (`command_exists`, `is_macos`, `path_add`, `load_file_if_exists`), which is tracked at this repo's root, then loads `.config/zsh/config/*.zsh` in a fixed order — `history`, `options`, `key-bindings`, `zinit`, `aliases`, `completions`, `functions`. Break that order and you can break dependencies between the files. The `evalcache`-wrapped inits (`mise`, `zoxide`, `fzf`, `direnv`) run after the loop. SDKMAN's init has to load last in the file — that's SDKMAN's own requirement, so don't move it up.

`.zlogin` runs `zcompile` over those files, which is where the gitignored `.zwc` siblings come from. It recompiles only when the source is newer, and only on a login shell. Leave them alone; never edit one directly.

### git identity lives outside this repo

`.config/git/config` has no `user.name`/`user.email` in it. Identity comes through two `gitdir`-scoped `includeIf` blocks pointing at `~/.gitconfig.d/*.inc` files — a catch-all for `~/`, and a more specific one for `~/dev/dnitros/` — both untracked and outside this repo. If `git who` or a commit's authorship looks wrong, the fix goes in the `.inc` files.

### Claude Code sandbox hardening (`.config/claude/settings.json`)

The native OS-level sandbox is the daily-driver security default. Some `settings.json` choices need explanation:

- `allowUnsandboxedCommands: false` turns off the `dangerouslyDisableSandbox` escape hatch completely — there's no per-command override once this is set.
- `excludedCommands` runs `docker *`, `gh *`, `terraform plan *`, and `git *` unsandboxed. `git` needs this because the sandbox's network proxy can't carry SSH traffic.
- `credentials.files` repeats the same paths already in `permissions.deny`; the sandbox and permission layers enforce independently, so file paths get listed in both. `credentials.envVars` (`ANTHROPIC_API_KEY`, `GITHUB_TOKEN`, AWS/Azure/GCP creds) has no `permissions.deny` counterpart — those are gated by the sandbox alone.
- npm and bun are sandboxed against their XDG cache dirs (`$XDG_CACHE_HOME/npm` etc., set in `.zprofile`) and fail to write there. brew hits the same wall through its own default cache and lock paths, which `.zprofile` never relocates. Opening write access for package managers was judged the worse trade, so this stays broken for now.
- `filesystem.denyWrite` protects `settings.json` itself — the global copy, per-project `.claude/settings.json`, and `.claude/settings.local.json` — from edits by Claude, and `permissions.deny` backs it up. Use the `update-config` skill to change a setting, or `/config` for simple ones.

### Two `CLAUDE.md` files

- This file (repo root): dotfiles-specific guidance. Excluded from Stow, so it never reaches `$HOME`. Project-specific notes belong here.
- `.config/claude/CLAUDE.md`: global instructions, symlinked to `~/.config/claude/CLAUDE.md` and applied to every project. Working relationship, process, and prose rules belong there.
