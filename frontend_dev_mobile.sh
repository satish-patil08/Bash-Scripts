#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install Basic Apps
# sudo snap install slack
sudo snap install webstorm --classic
sudo snap install postman
sudo apt install git -y

# Install NodeJS
sudo apt install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update && sudo apt install -y nodejs
sudo apt install gcc g++ make -y

# Install JDK (Java Development Kit)
sudo apt install openjdk-21-jdk

# Install Android Studio
sudo snap install android-studio --classic

# Set up Android SDK environment variables
echo "# Android SDK Environment Variables" >> ~/.bashrc
echo "export ANDROID_SDK_ROOT=\$HOME/Android/Sdk" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/emulator" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/tools" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/tools/bin" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_SDK_ROOT/platform-tools" >> ~/.bashrc
source ~/.bashrc

# Install Watchman (for better file watching in React Native)
sudo apt install autoconf automake build-essential python-dev libtool libssl-dev -y
git clone https://github.com/facebook/watchman.git
cd watchman
git checkout v4.9.0
./autogen.sh
./configure
make
sudo make install

# Install React Native CLI
sudo npm install -g react-native-cli

# Install additional libraries for React Native
sudo apt install lib32z1 lib32ncurses6 libbz2-1.0:i386 libstdc++6:i386 -y

# Install Yarn
npm install --global yarn

# Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f

# Final Restart
sudo apt update && sudo apt upgrade -y && sudo reboot now
