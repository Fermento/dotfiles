#!/bin/bash
export TERM=xterm-256color

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# Linux
	echo -e "\n\n>> LINUX"
	source ./linux/setup.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# Mac OSX
	echo -e "\n\n>> MACOSX"
	source ./macosx/setup.sh
fi

#HOSTS
#source hosts.sh

#GIT
echo -e "\n\n>> Git Setup"
echo "Git: User Name";
read git_username;
echo "Git: E-mail (@fermen.to)";
read git_email;

if [ -z "$git_username" ]; then
	echo ">> Configurando Username git config --global user.name $git_username;"
	git config --global user.name "$git_username";
fi
if [ -z "$git_email" ]; then
	git config --global user.email "$git_email";
fi;

git config --global push.default simple

# NPM
if ! [ -x "$(command -v pm2)" ]; then
	echo -e "\n\n>> NPM Setup"
	npm config set loglevel info
	sudo npm install -gq npm
	sudo npm install -gq nodemon tldr npm-check gulp speed-test pm2
fi

# Local Bin
if ! [ -d /usr/local/bin ]; then
	echo -e "\n\n>> Local Bin"
	mkdir -p /usr/local/bin
fi

# Bash Config
# rm ~/.bashrc
echo -e "\n\n>> .bash_profile"
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.bashrc ~/.bash_profile

# App Specific
if ! [ -f ~/.finicky.js ]; then
	echo -e "\n\n>> .gitconfig .bowerrc .editorconfig .gitignore_global .finicky.js"
	ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
	ln -sf ~/.dotfiles/.editorconfig ~/.editorconfig
	ln -sf ~/.dotfiles/.gitignore_global ~/.gitignore_global
fi