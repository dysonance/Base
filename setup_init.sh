if [ ! -d "$HOME/.vim" ]; then
    mkdir $HOME/.vim
fi

# setup vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c ":PlugInstall | :PlugUpdate | :qa"

# setup auto completer plugin for vim
cd $HOME/.vim/plugged/YouCompleteMe
./install.py
cd -

