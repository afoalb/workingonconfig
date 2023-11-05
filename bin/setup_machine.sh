#!/bin/bash

set -e  # exit script immediately on errors


install_packages() {

    packages=(
        'build-essential'  # c/c++ dev
        'clang'  #  c/c++ basic linter
        'cppcheck'  #  c/c++ linter (bit more advanced) 
        'flawfinder'  #  c/c++ linter (security related)
        'cmake'
        'gdb'  # c/c++ debugger
        'xterm'  # terminal emulator
        'tmux'
        'dmenu'
        'openssh-server'
        'python3-pip'
        'flake8'  # python linter
        'haskell-stack'  # haskell dev
        'xmonad'  # window manager
        'xmonad-contrib'  # xmonad imports
        'xmobar'  # panel
        'stalonetray'  # tray
        'xscreensaver' # screensaver
        'pcmanfm'  # file manager
        'shutter'  # screenshot
        'lxsession'  # session manager
    )

    echo "Starting to install packages..." 
    for package in "${packages[@]}"
    do 
        if ! hash "$package" 2>/dev/null; then
            echo "Installing ${package}..."
            sudo apt-get install "$package" -y || echo "!!! Something went wrong while installing ${package}." continue

            echo "${package} successfully installed."
        else
            echo "${package} already installed."
        fi
    done
}

set_default_apps() {
    echo "Setting default apps..."

    echo "Setting xterm as default terminal..."
    sudo update-alternatives --set x-terminal-emulator /usr/bin/xterm

    echo "Setting PCManFM as default file manager..."
    sudo xdg-mime default pcmanfm.desktop inode/directory

    echo "Setting python3.6 as default python3..."
    sudo update-alternatives --set python3 /usr/bin/python3.6
}

install_vim8() {
    echo "Adding PPA repo for vim 8.0..."
    sudo add-apt-repository ppa:jonathonf/vim -y
    sudo apt update
    echo "Installing vim 8.0..."
    sudo apt install vim -y
}

install_vim_plugin_manager() {
    # Note: plugin manager Vundle requires vim 8.0
    mkdir -p ~/.vim/bundle
    echo "Cloning Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
}

update_packages() {
    #  Haskell stack update
    sudo stack update
}

install_and_setup_plugins() {
    echo "Installing vim plugins..."
    vim +PluginInstall +qall

    echo "Installing YouCompleteMe support for c-family languages..."
    sudo apt install python-dev python3-dev -y
    python3 ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer

    echo "Installing exuberant ctgags for plugin: TagBar..."
    sudo apt-get install exuberant-ctags
}


# install python3.6 and pip install virtualenv
install_python_36() {
    echo "Installing requirements..."
    sudo apt-get install software-properties-common python-software-properties -y
    echo "Adding PPA repo for python 3.6..."
    sudo add-apt-repository ppa:jonathonf/python3.6
    sudo apt-get update
    echo "Installing python 3.6..."
    sudo apt-get install python3.6
}


main() {
    echo "Updating package manager..."
    sudo apt update && sudo apt upgrade -y
    install_packages
    update_packages

    install_vim8 && install_vim_plugin_manager && install_and_setup_plugins

    install_python_36

    set_default_apps
}

main
