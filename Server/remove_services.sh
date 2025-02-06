#!/bin/bash

# List of services to remove
services=(
    "backend-service-registry"
    "backend-clients"
    "backend-users"
    "backend-notifications"
)

for service in "${services[@]}"; do
    echo "🛑 Stopping and removing service: $service"

    # Stop the service if it's running
    sudo systemctl stop "$service"

    # Disable the service so it doesn't start on boot
    sudo systemctl disable "$service"

    # Remove the service file
    service_file="/etc/systemd/system/${service}.service"
    if [ -f "$service_file" ]; then
        sudo rm -f "$service_file"
        echo "✅ Removed service file: $service_file"
    else
        echo "⚠️ Service file not found: $service_file"
    fi

    # Reload systemd daemon to apply changes
    sudo systemctl daemon-reload

    # Ensure the service is completely removed
    sudo systemctl reset-failed "$service"

    echo "✅ Successfully removed service: $service"
done

echo "✅ All specified services have been removed."
