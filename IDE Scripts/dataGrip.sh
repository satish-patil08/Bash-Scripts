#!/bin/bash

# Define the DataGrip version and download URL

ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    DOWNLOAD_URL="https://download-cdn.jetbrains.com/datagrip/datagrip-243.21565.48.tar.gz"
elif [[ "$ARCH" == "aarch64" ]]; then
    DOWNLOAD_URL="https://download-cdn.jetbrains.com/datagrip/datagrip-243.21565.48-aarch64.tar.gz"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Download the DataGrip archive
echo "Downloading DataGrip..."
wget $DOWNLOAD_URL -O datagrip.tar.gz

# Extract the archive
echo "Extracting DataGrip..."
tar -xvzf datagrip.tar.gz

# Determine the extracted directory name
DIR=$(tar -tzf datagrip.tar.gz | head -1 | cut -f1 -d"/")

# Move DataGrip to /opt
echo "Moving DataGrip to /opt..."
sudo mv "$DIR" /opt/datagrip

# Start DataGrip to initialize configuration files
echo "Starting DataGrip to initialize configuration..."
/opt/datagrip/bin/datagrip.sh &

# Optional: Add DataGrip to the PATH
echo "Do you want to add DataGrip to your PATH? (y/n)"
read -r ADD_TO_PATH
if [[ "$ADD_TO_PATH" == "y" ]]; then
    echo "Adding DataGrip to your PATH..."
    echo 'export PATH=$PATH:/opt/datagrip/bin' >> ~/.bashrc
    source ~/.bashrc
fi

# Optional: Instructions for JVM heap size configuration
echo "If you wish to adjust the JVM heap size, create a file named datagrip.vmoptions"
echo "in ~/.config/JetBrains/DataGrip2024.3 and set the -Xms and -Xmx parameters."
echo "Reference the file under /opt/datagrip/bin as a model."

# Optional: Instructions for changing the configuration and system directories
echo "To change the location of config and system directories, create a file named idea.properties"
echo "in ~/.config/JetBrains/DataGrip2024.3 and set idea.system.path and idea.config.path variables."
echo "Example:"
echo "  idea.system.path=~/custom/system"
echo "  idea.config.path=~/custom/config"

# Clean up the downloaded archive
echo "Cleaning up..."
rm datagrip.tar.gz

echo "DataGrip installation complete. Enjoy!"

