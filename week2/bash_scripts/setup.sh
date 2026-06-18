#!/bin/bash
# System setup script — installs essential tools and updates the system
# Usage: ./setup.sh

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing essential tools..."
sudo apt install -y git curl wget build-essential ufw

echo "Setup complete!"
