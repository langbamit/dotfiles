#!/usr/bin/env sh
# SRC_DIR := $(PWD)

read -r option

case $option in

"1")
    echo -e "\u001b[7m Installing nodenv... \u001b[0m"
    if ! [[ -d "$HOME/.nodenv" ]]; then
        
        git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv
        cd $HOME/.nodenv && src/configure && make -C src
        cd $SRC_DIR
    else
        echo -e "\u001b[7m Ignore install because nodenv existing. \u001b[0m"
    fi
    ;;

"2")

    ;;

"3")
    echo -e "\u001b[7m Installing vim plugins... \u001b[0m"
    nvim +PlugUpdate +PlugInstall +qall
    nvim '+CocInstall coc-json coc-rls coc-tsserver' +qall
    ;;

"4")echo -e "\u001b[7m Installing tmux plugins... \u001b[0m"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux start-server
    tmux new-session -d
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    tmux kill-server
    ;;

"5")echo -e "\u001b[7m Setting up symlinks... \u001b[0m"
    echo -e "\u001b[33;1m Backing up existing files... \u001b[0m"
    mv -iv ~/.Xresources ~/.Xresources.old
    mv -iv ~/.config/i3 ~/.config/i3.old
    mv -iv ~/.config/ranger ~/.config/ranger.old
    mv -iv ~/.gitconfig ~/.gitconfig.old
    mv -iv ~/.tmux.conf ~/.tmux.conf.old
    mv -iv ~/.zshrc ~/.zshrc.old

    echo -e "\u001b[36;1m Adding symlinks...\u001b[0m"
    ln -sfnv "$PWD/.Xresources" ~/.Xresources
    ln -sfnv "$PWD/.config/i3" ~/.config/i3
    ln -sfnv "$PWD/.config/ranger/" ~/.config/ranger
    ln -sfnv "$PWD/.gitconfig" ~/.gitconfig
    ln -sfnv "$PWD/.tmux.conf" ~/.tmux.conf
    ln -sfnv "$PWD/.config/nvim" ~/.config/nvim
    ln -sfnv "$PWD/.zshrc" ~/.zshrc

    echo -e "\u001b[36;1m Remove backups with 'rm -ir ~/.*.old && rm -ir ~/.config/*.old'. \u001b[0m"
    ;;

"0")echo -e "\u001b[32;1m Bye! \u001b[0m"
    exit 0
    ;;

*)echo -e "\u001b[31;1m Invalid option entered! \u001b[0m"
    exit 1
    ;;
esac

exit 0
