# Silver's Zsh config

This repo contains my zsh config files. It's mainly based on `zinit` framework.

## Step by step

- Install `zsh`, and some common tools: `git`, `curl`
- Setup `starship`
  ```bash
  curl -sS https://starship.rs/install.sh | sh
  curl -sSL https://github.com/silverling/zsh-config/raw/main/starship.toml -o ~/.config/starship.toml
  ```
- Setup `zinit`
  ```bash
  curl -sSL https://github.com/silverling/zsh-config/raw/main/zshrc -o ~/.zshrc
  ```
