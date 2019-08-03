#!/bin/bash

# update existing catalogue and packages
sudo apt-get update
sudo apt-get -y upgrade

# install nodejs 10.x
sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get install -y nodejs
# optional build tools for node packages
sudo apt-get install -y build-essential

# install docker - (see https://docs.docker.com/v17.12/install/linux/docker-ce/debian/#set-up-the-repository)
sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce
# to avoid needing sudo, use 2 lines below - works after restarting vm
sudo groupadd docker
sudo usermod -aG docker $USER

# Configure git to store credentials
git config --global credential.helper store

#jetBrains toolbox
sudo apt-get -y install fuse
#sudo apt-get -y install libnss3
curl -sL https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.15.5666.tar.gz | sudo tar -xz -C /opt

cd /opt/jetbrains-toolbox*
sudo chmod u+x ./jetbrains-toolbox
# not sure if this next step is needed before toolbox will show in the dock?
./jetbrains-toolbox

# install firefox - installs to /opt/firefox/firefox
curl -sL "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" | sudo tar -xjf /opt

# to inegrate firefox with the dock
cat <<EOT >> ~/.local/share/applications/firefox.desktop
[Desktop Entry]
Name=Firefox
Comment=Browse the World Wide Web
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Exec=env MOZ_USE_XINPUT2=1 /opt/firefox/firefox %u
Type=Application
Categories=Network;WebBrowser;
EOT