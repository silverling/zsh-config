# Silver's Zsh config

This repo contains my zsh config files. It's mainly based on `zinit` framework.

## Step by step

- Install `zsh`, and some common tools: `git`, `curl`
- Install `starship`
  - Run: `curl -sS https://starship.rs/install.sh | sh`
- Setup `zinit`
  ```
  curl -sSL https://github.com/silverling/zsh-config/raw/main/starship.toml -o ~/.config/starship.toml
  curl -sSL https://github.com/silverling/zsh-config/raw/main/zshrc -o ~/.zshrc
  ```
