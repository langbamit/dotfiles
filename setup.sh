
#!/usr/bin/env sh
cd
curl https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf -o .tmux.conf
curl https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf.local -o .tmux.conf.local


curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall > /dev/null
nvim +CocInstall coc-rls coc-tsserver coc-json coc-css coc-html coc-python +qall
