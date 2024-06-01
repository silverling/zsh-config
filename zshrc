# == zinit ==
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


# == plugins ==
zinit ice depth'1'; zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice depth'1'; zinit light zsh-users/zsh-completions
zinit ice depth'1'; zinit light zsh-users/zsh-autosuggestions


# == snippets ==
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/git/git.plugin.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/history.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/clipboard.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/key-bindings.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/completion.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/directories.zsh


# == fzf ==
zinit ice has'fzf'; zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/fzf/fzf.plugin.zsh
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
zinit ice has'fzf' depth'1' wait lucid; zinit light joshskidmore/zsh-fzf-history-search


# == starship ==
## install starship: curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"
autoload -Uz compinit && compinit
