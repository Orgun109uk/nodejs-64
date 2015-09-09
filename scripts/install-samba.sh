#!/bin/bash -e

echo "Setup workspace."
mkdir /home/vagrant/workspace
chown vagrant:vagrant /home/vagrant/workspace

#######################################################################################################################
# Install SAMBA.
sudo apt-get install -y samba

#######################################################################################################################
# Setup SAMBA.
(echo "vagrant"; echo "vagrant")|smbpasswd -a vagrant

echo "" >> /etc/samba/smb.conf
echo "[workspace]" >> /etc/samba/smb.conf
echo "path = /home/vagrant/workspace" >> /etc/samba/smb.conf
echo "available = yes" >> /etc/samba/smb.conf
echo "valid users = vagrant" >> /etc/samba/smb.conf
echo "read only = no" >> /etc/samba/smb.conf
echo "browseable = yes" >> /etc/samba/smb.conf
echo "public = yes" >> /etc/samba/smb.conf
echo "writable = yes" >> /etc/samba/smb.conf
echo "" >> /etc/samba/smb.conf

#######################################################################################################################
# Performance tweeks.
sed -i.bak 's|^;   bind interfaces only = yes|;   bind interfaces only = yes\n\nsocket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=65536 SO_SNDBUF=65536|' /etc/samba/smb.conf
