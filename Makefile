HOSTNAME = $(shell hostname)
UNAME = $(shell uname)
ID = $(shell whoami)
export PATH := $(PATH):$(HOME)/.nix-profile/bin

.PHONY: install-nix install-zsh install-vim

all: install-nix install-zsh install-vim install-dotfiles

/nix:
	sudo echo "Warming up the brain farm"
	curl "https://nixos.org/nix/install" | bash

install-nix: | /nix
	install -d -m 0755 $(HOME)/.config/nixpkgs
	ln -sf $(CURDIR)/config.nix $(HOME)/.config/nixpkgs/config.nix
	nix-env -i user-env
	
$(HOME)/.zplug:
	git clone https://github.com/zplug/zplug $(HOME)/.zplug

install-zsh: | $(HOME)/.zplug
	ln -sf $(CURDIR)/zsh/rc $(HOME)/.zshrc
	install -d -m 0755 $(HOME)/.zsh
	ln -sf $(CURDIR)/zsh/aliases $(HOME)/.zsh/aliases
	ln -sf $(CURDIR)/zsh/settings $(HOME)/.zsh/settings
	ln -sf $(CURDIR)/zsh/zsh.plugin.zsh $(HOME)/.zsh/zsh.plugin.zsh
	ln -sf $(CURDIR)/zsh/lib $(HOME)/.zsh/lib

$(HOME)/.config/nvim $(HOME)/.local/share/nvim:
	install -d -m 0755 $@

$(HOME)/.local/share/nvim/site/autoload/plug.vim: | $(HOME)/.local/share/nvim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install-vim: | $(HOME)/.config/nvim $(HOME)/.local/share/nvim/site/autoload/plug.vim
	ln -sf $(CURDIR)/vimrc $(HOME)/.config/nvim/init.vim
	nvim +PlugInstall +qall

install-dotfiles:
	ln -sf $(CURDIR)/gitconfig $(HOME)/.gitconfig

fonts: 
	git submodule update --init --recursive

install-fonts: | fonts
	cd fonts; ./install.sh "Meslo LG M DZ"
