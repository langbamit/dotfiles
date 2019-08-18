default: install
SRC_DIR := $(CURDIR)
INSTALL_DIR := ~/.config/nvim

mkdir:
	[ ! -f $(INSTALL_DIR) ] && mkdir -pv $(INSTALL_DIR)
	[ ! -f $(INSTALL_DIR)/init.vim ] && touch $(INSTALL_DIR)/init.vim
config:
	printf '\nsource $(CURDIR)/init.vim' >> $(INSTALL_DIR)/init.vim; 
clean:
	sed -i 's|source $(CURDIR)/init.vim||' $(INSTALL_DIR)/init.vim
install: mkdir clean config
	vim +PlugInstall +qall