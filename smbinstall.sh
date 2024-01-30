#!/bin/bash

# Install Samba
sudo apt update
sudo apt install -y samba

# Backup Samba configuration
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak

# Get user input
read -p "Enter your share name: " SHARE_NAME
read -p "Enter the path to your shared folder: " SHARE_PATH
read -p "Enter the Samba username: " SAMBA_USERNAME

# Configure Samba
sudo bash -c "cat >> /etc/samba/smb.conf" <<EOL

[$SHARE_NAME]
    path = $SHARE_PATH
    read only = no
    browseable = yes
    guest ok = yes
EOL

# Restart Samba
sudo service smbd restart

# Add Samba user
sudo smbpasswd -a $SAMBA_USERNAME

echo "Samba setup completed. Your share is accessible at smb://$(hostname)/$SHARE_NAME"
