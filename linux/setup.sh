#!/bin/bash
echo -e "\n\n>> Iniciando Instalacao Linux"

if verb="$( which apt-get )" 2> /dev/null; then
    echo -e "\n\n>> Utilizando instalado $verb"
elif verb="$( which dnf )" 2> /dev/null; then
    echo -e "\n\n>> Utilizando instalado $verb"
else
    echo -e "\n\n>> Sistema ainda não suportado :/" >&2
    exit 1
fi

# HORARIO BIOS COMO LOCAL
# timedatectl set-local-rtc 1 --adjust-system-clock

sudo $verb -y update
if ! [ -x "$(command -v git)" ]; then
    sudo $verb -y install git-core git
fi

# DevTools (Loop por comandos)
for devTool in make automake autoconf pkg-config bison flex curl gcc g++ python3 python3-venv php-fpm mariadb-server; do
	if ! [ -x "$(command -v $devTool)" ]; then
        echo -e "\n\n>> Instalando $devTool"
        sudo $verb -y install $devtool
    fi
done;

# Configurando python
if ! [ -x "$(command -v python)" ]; then
    echo -e "\n\n>> Configurando /usr/local/bin/python para $(which python3)"
    sudo ln -s "$(which python3)" /usr/local/bin/python
fi

# Configurando python
# TODO: Pegar versão do FPM automaticamente. E.g, php --version | grep -o " \([0-9].[0-9]\)\.[0-9]"
if ! [ -x "$(command -v php-fpm)" ]; then
    echo -e "\n\n>> Configurando /usr/local/bin/php-fpm para $(which php-fpm7.4)"
    sudo ln -s "$(which php-fpm7.4)" /usr/local/bin/php-fpm
    # Instalar libs php7.4-xml php7.4-zip php7.4-pdo php7.4-mbstring php7.4-gd php7.4-mysqlnd php7.4-bcmath php7.4-fpm php7.4-json
fi

if ! [ -x "$(command -v node)" ]; then
    echo -e "\n\n>> Instalando Node"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm install --lts
    nvm use --lts
fi

# Se Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    sudo $verb -y install gnome-tweaks telegram-desktop
    sudo $verb -y install flatpak flameshot snapd

    # SNAP
    if [ -x"$(command -v snap)" ]; then
        sudo service snap start
        sudo ln -s /var/lib/snapd/snap /snap 2>/dev/null
        sudo snap install spotify mailspring wps-office-multilang
        sudo snap install --classic sublime-text 
        sudo snap install --classic code
    fi

    # FLATPAK
    if [ -x "$(command -v flatpak)" ]; then
        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        sudo flatpak install -y GitKraken Discord net.xmind.XMind8 Franz
    fi
fi 

sudo $verb -y autoremove

# Instala AWS
if ! [ -x "$(command -v aws)" ]; then
    cd /tmp
    curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
    unzip -f awscli-bundle.zip
    sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
fi

#USER/GROUP
echo -e "\n\n>> Group $MAIN_GROUP"
sudo groupadd -f $MAIN_GROUP
sudo usermod -g $MAIN_GROUP "$(whoami)"