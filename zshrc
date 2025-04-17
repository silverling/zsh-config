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

# == keybindings ==
bindkey -e
bindkey '^[[H' beginning-of-line        # Home
bindkey '^[[F' end-of-line              # End
bindkey '^H'   backward-kill-word       # Ctrl + Backspace
## non-alphabetical chars to considered be the part of word, this is useful for kill-word
export WORDCHARS=''
bindkey '^[[1;5D' backward-word                     # Ctrl+Left
bindkey '^[[1;5C' forward-word                      # Ctrl+Right
bindkey '^[[A' history-beginning-search-backward    # Up key
bindkey '^[[B' history-beginning-search-forward     # Down key
## DO NOT EAT MY SPACE!
export ZLE_REMOVE_SUFFIX_CHARS=''

# == starship(prompt) ==
## install starship: curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"
autoload -Uz compinit && compinit

# == path ==
prepend_path() {
    local _path="$1"
    if [ -d "$_path" ] && [[ ":$PATH:" != *":$_path:" ]]; then
        export PATH="$_path${PATH:+":$PATH"}"
    fi
}

append_path() {
    local _path="$1"
    if [ -d "$_path" ] && [[ ":$PATH:" != *":$_path:"* ]]; then
        export PATH="${PATH:+"$PATH:"}$_path"
    fi
}

prepend_path "$HOME/.local/bin"

# == common env ==
export EDITOR=nvim
[ "${LC_ALL}x" = "x" ] && export LC_ALL=en_US.UTF-8

# == common alias ==
alias vi='nvim'
alias vim='nvim'
alias cs="${EDITOR} $HOME/.zshrc" # config shell
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
prepend_path "$N_PREFIX/bin"
alias pp='pnpm'

# == python ==
export UV_HTTP_TIMEOUT=900
export UV_PYTHON_PREFERENCE="only-managed"
export UV_INDEX="https://mirrors.pku.edu.cn/pypi/web/simple"
export UV_DEFAULT_INDEX="https://mirrors.pku.edu.cn/pypi/web/simple"
export VIRTUAL_ENV_DISABLE_PROMPT=true

# == micromamba ==
alias mm='micromamba'
alias ma='micromamba activate'
alias me='micromamba deactivate'

# Make sure to put this at the end of the file, so these customizations can override the settings above
# == other customizations ==
if [ -d $HOME/.zshrc.d ]; then
    for f in $HOME/.zshrc.d/*.zsh; do
        source $f
    done
fi
