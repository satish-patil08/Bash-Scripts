sudo apt update && sudo apt upgrade -y

# Install Basic Apps
sudo snap install intellij-idea-community --classic
sudo snap install postman
sudo apt install git -y

# Install MongoDB IDE
wget https://downloads.mongodb.com/compass/mongodb-compass_1.43.0_amd64.deb
sudo dpkg -i mongodb-compass_1.43.0_amd64.deb
sudo apt-get install -f

# Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f

# Install Java JDK
sudo apt install openjdk-21-jdk

# Install Maven
sudo apt install maven -y

#Install DataGrip Classic
sudo snap install datagrip --classic

# Download DataGrip EAP
# wget https://download-cdn.jetbrains.com/datagrip/datagrip-243.21565.48-aarch64.tar.gz

# Extract the downloaded archive
# tar -xvzf datagrip-243.21565.48-aarch64.tar.gz

# Move the extracted DataGrip directory to /opt
# sudo mv DataGrip-243.21565.48 /opt/datagrip

# Navigate to the DataGrip bin directory
# cd /opt/datagrip/bin

# Run DataGrip
# ./datagrip &

# Create a desktop entry for DataGrip EAP
# sudo bash -c 'cat <<EOF > /usr/share/applications/datagrip-eap.desktop
# [Desktop Entry]
# Name=DataGrip EAP
# Exec=/opt/datagrip/bin/datagrip.sh
# Icon=/opt/datagrip/bin/datagrip.png
# Type=Application
# Categories=Development;IDE;
# Terminal=false
# EOF'

# Make the desktop entry executable
# sudo chmod +x /usr/share/applications/datagrip-eap.desktop

# Final Restart
sudo apt update && sudo apt upgrade -y && sudo reboot now


