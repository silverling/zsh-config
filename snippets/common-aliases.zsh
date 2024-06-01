# Common aliases

alias cs="${EDITOR:-hx} $HOME/.zshrc"   # config shell
alias sc="exec zsh"                     # source config

alias ls='ls -h --color=tty '
alias ll='ls -l '
alias la='ls -la'
alias sudo='sudo -E '
alias diff='diff --color=auto'

alias c="clear"
alias sizeof="du -h --max-depth=0"
alias showpath="sed 's/:/\n/g' <<< \$PATH"
alias dec='printf "%d\n"'               # decimal