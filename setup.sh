#!/usr/bin/bash

set -eu
distro=$(cat /etc/os-release | grep '^ID=' | cut -d'=' -f2)

# == install zsh ==
function install_zsh {
    echo "Install zsh"
    if [ $distro = "arch" ]; then
        sudo pacman -S zsh --noconfirm
    elif [ $distro = "ubuntu" ]; then
        sudo apt install zsh -y
    elif [ $distro = "debian" ]; then
        sudo apt install zsh -y
    else
        echo "Unknown distro"
        exit 1
    fi
    echo "zsh installed"
}

# == install starship ==
function install_starship {
    if [ -f /usr/local/bin/starship ]; then
        echo "starship already installed"
        return
    fi

    echo "Install starship"
    if [ $distro = "arch" ]; then
        sudo pacman -S starship --noconfirm
    else
        curl -sS https://starship.rs/install.sh | sh -s -- -y
        if [ $? -ne 0 ]; then
            echo "Failed to install starship"
            exit 1
        fi
    fi
    echo "starship installed"
}

# == backup old zshrc ==
function backup_zshrc {
    if [ -f $HOME/.zshrc ]; then
        mv $HOME/.zshrc $HOME/.zshrc.bak
    fi
}

# == download zshrc ==
function download_zshrc {
    curl -sS https://raw.githubusercontent.com/silverling/zsh-config/main/zshrc >$HOME/.zshrc
}

# == backup old starship.toml ==
function backup_starship_toml {
    if [ -f $HOME/.config/starship.toml ]; then
        mv $HOME/.config/starship.toml $HOME/.config/starship.toml.bak
    fi
}

# == download starship.toml ==
function download_starship_toml {
    mkdir -p $HOME/.config
    curl -sS https://raw.githubusercontent.com/silverling/zsh-config/main/starship.toml >$HOME/.config/starship.toml
}

# == set default shell ==
function set_default_shell {
    chsh -s $(which zsh)
}

# == main ==
function main {
    install_zsh
    install_starship
    backup_zshrc
    download_zshrc
    backup_starship_toml
    download_starship_toml
    set_default_shell

    echo "Done"
    cat <<EOF
Please relogin or run the following command to apply the changes:

    exec zsh

EOF
}

main
