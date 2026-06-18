#!/bin/bash
# User creation script
# Usage: ./user_setup.sh <username>

USERNAME=$1

if [ -z "$USERNAME" ]; then
    echo "Usage: ./user_setup.sh <username>"
    exit 1
fi

sudo adduser "$USERNAME"
sudo usermod -aG sudo "$USERNAME"

echo "User $USERNAME created and added to sudo group."
