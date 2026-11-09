# Dotfiles

This repository contains my personal configuration files (dotfiles).  
They are managed using [GNU Stow](https://www.gnu.org/software/stow/), which creates symlinks from this repo into your `$HOME` directory.  

---

## Prerequisites

Ensure that Git and GNU Stow are installed on your system.

### Homebrew
```bash
brew install git stow
```

## Debian
```bash
sudo apt install git stow -y
```

---

## Installation

1. Clone this repository into your `$HOME` directory:
   ```bash
   cd
   mkdir -p "${HOME}/.config"
   mkdir -p "${HOME}/.config/nono/profiles"
   mkdir -p "${HOME}/.claude"
   git clone https://github.com/dnitros/dotfiles.git
   cd dotfiles
   ```

2. Use **GNU Stow** to create symlinks:
   ```bash
   stow --dotfiles -t "${HOME}" .
   ```

This will symlink the configuration files into your home directory.

3. Install the agent skills that `settings.json` can't declare. They need `uv` and Node 18 or later, both in the Brewfile (`brew bundle`):
   ```bash
   uv tool install graphifyy
   graphify install
   npx -y skills@1.7.6 add https://github.com/tt-a1i/archify --skill archify --agent claude-code --global --copy --yes
   ```

---

## Removing symlinks
To remove symlinks created by Stow:

```bash
stow --dotfiles -t "${HOME}" -D .
```
