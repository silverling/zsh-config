# == zinit ==
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# == zinit plugins ==
zinit ice depth'1'
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice depth'1'
zinit light zsh-users/zsh-completions
zinit ice depth'1'
zinit light zsh-users/zsh-autosuggestions

# == zinit snippets ==
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/git/git.plugin.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/history.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/clipboard.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/key-bindings.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/completion.zsh
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/directories.zsh

# == fzf ==
zinit ice has'fzf'
zinit snippet https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/fzf/fzf.plugin.zsh
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
zinit ice has'fzf' depth'1' wait lucid
zinit light joshskidmore/zsh-fzf-history-search

# == starship ==
## install starship: curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"
autoload -Uz compinit && compinit

# == path ==
append_path() {
    local _path="$1"
    if [ -d "$_path" ] && [[ ":$PATH:" != *":$_path:"* ]]; then
        export PATH="${PATH:+"$PATH:"}$_path"
    fi
}
export PATH="$HOME/.local/bin:$PATH"

# == common env ==
export EDITOR=nvim
[ "${LC_ALL}x" = "x" ] && export LC_ALL=en_US.UTF-8

# == common alias ==
alias vi='nvim'
alias vim='nvim'
alias cs="${EDITOR:-nvim} $HOME/.zshrc" # config shell
alias sc='exec zsh'                     # source config

alias ls='ls -h --color=tty '
alias ll='ls -l '
alias la='ls -la'
alias sudo='sudo -E '
alias diff='diff --color=auto'

alias c='clear'
alias sizeof='du -h --max-depth=0'
alias showpath="sed 's/:/\n/g' <<< \$PATH"
alias dec='printf "%d\n"' # decimal

# == tweaks ==
export LIBPROC_HIDE_KERNEL=1 # hide kernel threads for `ps` command

# == utils ==
function urldecode() {
    python3 -c 'import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()) if len(sys.argv) <= 1 else "\n".join([unquote(arg) for arg in sys.argv[1:]]))' $@
}

function enable_proxy() {
    local _PROXY="http://<proxy>:<port>"
    ## wget and some programs prefer lower case environment variables
    export http_proxy=$_PROXY
    export https_proxy=$_PROXY
    export all_proxy=$_PROXY
    export HTTP_PROXY=$_PROXY
    export HTTPS_PROXY=$_PROXY
    export ALL_PROXY=$_PROXY
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    unset _PROXY
}

function disable_proxy() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset ALL_PROXY
    unset no_proxy
}

# == golang ==
export GOPATH="$HOME/.go"

# == nodejs ==
## install n: curl -L https://bit.ly/n-install | bash
## note: n is not compatible with msys2
export N_PREFIX="$HOME/.n"
alias pp='pnpm'

# == python ==
export UV_HTTP_TIMEOUT=900
export UV_PYTHON_PREFERENCE="only-managed"
export UV_INDEX="https://mirrors.pku.edu.cn/pypi/web/simple"
export UV_DEFAULT_INDEX="https://mirrors.pku.edu.cn/pypi/web/simple"
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Make sure to put this at the end of the file, the customizations can override the settings above
# == other customizations ==
if [ -d $HOME/.zshrc.d ]; then
    for f in $HOME/.zshrc.d/*.zsh; do
        source $f
    done
fi
