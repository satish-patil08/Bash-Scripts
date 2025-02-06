#!/bin/bash

sudo apt update && sudo apt upgrade -y


# Install Java JDK
echo "<------------- Installing Java ------------>"
sudo apt install openjdk-21-jdk -y
java -version

# Install Maven
echo "<------------- Installing Maven ------------>"
sudo apt install maven -y

# Install Git
echo "<------------- Installing Git ------------>"
sudo apt install git -y


# Install NodeJS
echo "<------------- Installing NodeJS ------------>"
sudo apt install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update && sudo apt install -y nodejs gcc g++ make
node -v
npm -v

# Install React Native CLI
echo "<------------- Installing React Netive CLI ------------>"
sudo npm install -g @react-native-community/cli

# Install additional libraries for React Native
sudo apt install lib32z1 lib32ncurses6 libbz2-1.0:i386 libstdc++6:i386 -y


# Install Jenkins
echo "<------------- Installing Jenkins ------------>"
wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update && sudo apt install jenkins -y


# Enable & Start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins --no-pager


# Install Nginx
echo "<------------- Installing Nginx Server ------------>"
sudo apt install nginx -y

# Enable & Start Nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx --no-pager

# Allow Nginx traffic through firewall
sudo ufw allow 'Nginx HTTP'



# ------------------------ NOTES ------------------------
# DONT COPY THIS NOTE WHILE COPYING THE SCRIPT
#
# HOW TO RUN THIS SCRIPT:
# 1. Save this script as setup.sh
#    nano setup.sh
#    (Paste the script inside and save it with CTRL + X, then Y, then Enter)
#
# 2. Give execution permission:
#    chmod +x setup.sh
#
# 3. Run the script:
#    ./setup.sh
#
# POST-INSTALLATION CHECKS:
# - Check Jenkins status: systemctl status jenkins
# - Check Nginx status: systemctl status nginx
# - Open http://your-server-ip/ in a browser to check Nginx
# -------------------------------------------------------