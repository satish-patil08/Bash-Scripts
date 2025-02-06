#!/bin/bash

# Define an array of service names and their respective JAR paths
declare -A services=(
    ["backend-service-registry"]="/var/lib/jenkins/backend/backend-service-registry/app.jar"
    ["backend-users"]="/var/lib/jenkins/backend/backend-users/app.jar"
    ["backend-notification"]="/var/lib/jenkins/backend/backend-notification/app.jar"
    ["backend-clients"]="/var/lib/jenkins/backend/backend-clients/app.jar"
)

# Loop through each service and create its systemd service file
for service in "${!services[@]}"; do
    jar_path="${services[$service]}"
    service_file="/etc/systemd/system/${service}.service"

    echo "Creating systemd service for ${service} at $service_file..."

    sudo bash -c "cat > $service_file" <<EOF
[Unit]
Description=${service^} Service
After=network.target

[Service]
User=azureuser
WorkingDirectory=$(dirname "$jar_path")
ExecStart=/usr/bin/java -jar $jar_path
SuccessExitStatus=143
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

    # Ensure the directory exists
    sudo mkdir -p "$(dirname "$jar_path")"

    # Reload systemd, enable, and start the service
    sudo systemctl daemon-reload
    sudo systemctl enable "$service"
    sudo systemctl restart "$service"

    echo "✅ Service ${service} created and started successfully."
done

echo "✅ All services have been set up in /etc/systemd/system/."
