#!/usr/bin/sh

set -eu

BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

distro=$(cat /etc/os-release | grep '^ID=' | cut -d'=' -f2)

# == print functions ==
info() {
    printf '%s\n' "${BOLD}${GREY}==>${NO_COLOR} $*"
}

error() {
    printf '%s\n' "${RED}==x $*${NO_COLOR}" >&2
}

# == install git ==
install_git() {
    if [ -x "$(command -v git)" ]; then
        info "git already installed"
        return
    fi

    info "Install git"
    if [ $distro = "arch" ]; then
        sudo pacman -S git --noconfirm
    elif [ $distro = "ubuntu" ]; then
        sudo apt install git -y
    elif [ $distro = "debian" ]; then
        sudo apt install git -y
    elif [ $distro = "msys2" ]; then
        pacman -S git --noconfirm
    else
        error "Unknown distro"
        exit 1
    fi
    info "git installed"
}

# == install curl ==
install_curl() {
    if [ -x "$(command -v curl)" ]; then
        info "curl already installed"
        return
    fi

    info "Install curl"
    if [ $distro = "arch" ]; then
        sudo pacman -S curl --noconfirm
    elif [ $distro = "ubuntu" ]; then
        sudo apt install curl -y
    elif [ $distro = "debian" ]; then
        sudo apt install curl -y
    elif [ $distro = "msys2" ]; then
        pacman -S curl --noconfirm
    else
        error "Unknown distro"
        exit 1
    fi
    info "curl installed"
}

# == install zsh ==
install_zsh() {
    if [ -x "$(command -v zsh)" ]; then
        info "zsh already installed"
        return
    fi

    info "Install zsh"
    if [ $distro = "arch" ]; then
        sudo pacman -S zsh --noconfirm
    elif [ $distro = "ubuntu" ]; then
        sudo apt install zsh -y
    elif [ $distro = "debian" ]; then
        sudo apt install zsh -y
    elif [ $distro = "msys2" ]; then
        pacman -S zsh --noconfirm
    else
        error "Unknown distro"
        exit 1
    fi
    info "zsh installed"
}

# == install starship ==
install_starship() {
    if [ -x "$(command -v starship)" ]; then
        info "starship already installed"
        return
    fi

    info "Install starship"
    if [ $distro = "arch" ]; then
        sudo pacman -S starship --noconfirm
    else
        if [ $distro = "msys2" ]; then
            [ -d "/usr/local/bin" ] || mkdir -p /usr/local/bin
        fi
        curl -sS https://starship.rs/install.sh | sh -s -- -y
        if [ $? -ne 0 ]; then
            error "Failed to install starship"
            exit 1
        fi
    fi
    info "starship installed"
}

# == install unzip ==
install_unzip() {
    if [ -x "$(command -v unzip)" ]; then
        info "unzip already installed"
        return
    fi

    info "Install unzip"
    if [ $distro = "arch" ]; then
        sudo pacman -S unzip --noconfirm
    elif [ $distro = "ubuntu" ]; then
        sudo apt install unzip -y
    elif [ $distro = "debian" ]; then
        sudo apt install unzip -y
    elif [ $distro = "msys2" ]; then
        pacman -S unzip --noconfirm
    else
        error "Unknown distro"
        exit 1
    fi
    info "unzip installed"
}

# == backup old zshrc ==
backup_zshrc() {
    if [ -f $HOME/.zshrc ]; then
        mv $HOME/.zshrc $HOME/.zshrc.bak
    fi
}

# == download zshrc ==
download_zshrc() {
    curl -sS https://raw.githubusercontent.com/silverling/zsh-config/main/zshrc >$HOME/.zshrc
}

# == backup old starship.toml ==
backup_starship_toml() {
    if [ -f $HOME/.config/starship.toml ]; then
        mv $HOME/.config/starship.toml $HOME/.config/starship.toml.bak
    fi
}

# == download starship.toml ==
download_starship_toml() {
    mkdir -p $HOME/.config
    curl -sS https://raw.githubusercontent.com/silverling/zsh-config/main/starship.toml >$HOME/.config/starship.toml
}

# == set default shell ==
set_default_shell() {
    chsh -s $(which zsh)
}

# == main ==
main() {
    install_git
    install_curl
    install_zsh
    install_starship
    backup_zshrc
    download_zshrc
    backup_starship_toml
    download_starship_toml
    set_default_shell

    info "Done"
    cat <<EOF
Please relogin or run the following command to apply the changes:

    exec zsh

If you need network proxy, please set the following environment variables:

    export http_proxy=http://<proxy>:<port>
    export https_proxy=http://<proxy>:<port>

then:

    exec zsh

EOF
}

main
