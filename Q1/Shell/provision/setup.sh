#!/bin/bash
# Title: setup.sh
# Date: 03/21/2015
# Author: Joseph J. Simpson
# Purpose: Set up a Centos 6.6 Box
# Version 0.1.0
# License:
#   Setup.sh Provision a CentOS 6.6 Q1 machnie
#   Copyright (C) 2017  Joseph J. Simpson
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software Foundation,
#  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
#

echo "Provisioning the CentOS 6.6 virtrual machine.."
echo 'Update ssd config to remove root login'
cd /etc/ssh/
cp sshd_config sshd_config_bu
cd ~
echo "Change #PermitRootLogin Yes to PermitRootLogin No"
echo "Later by hand and restart ssh with sudo service sshd restart"
echo "Updating yum .."

sudo yum update

echo "Finished updating yum .."
echo "Install man pages"

sudo yum install man -y

echo "Finished installing man.."
echo "Install vim"

sudo yum install vim -y

echo "Finished installing vim.."
echo "Install vim-enhanced"

sudo install vim-enhanced -y

echo "Finished installing vim-enhanced.."
echo "Install lsscsi"

sudo yum install lsscsi.i686 -y

echo "Finished installing lsscsi.."
echo "Install dstat"

sudo yum install dstat -y

echo "Finished installing dstat.."
echo "Install wget"

sudo yum install wget -y

echo "Finished installing wget"
echo "Install locate"

sudo yum install locate -y

echo "Finished installing locate"
echo "Install bind"

sudo yum install bind -y

echo "Finished installing bind.."
echo "Install bind-utils"

sudo yum install bind-utils -y

echo "Finished installing bind-utils"
echo "Group Install Web Server"

sudo yum groupinstall "Web Server"

echo "Finished group installing Web Server"
echo "Create user vbc6u1"

sudo /usr/sbin/useradd -c "Virtural Box CentOS 6 User One" -G wheel vbc6u1

echo "Finished creating vbc6u1.."
echo "Create user vbc6u2"

sudo /usr/sbin/useradd -c "Virtural Box CentOS 6 User Two" -G wheel vbc6u2

echo "Finished creating vbc6u2.."
echo "Create vbc6u1 authorized_keys file"

sudo mkdir /home/vbc6u1/.ssh
sudo touch /home/vbc6u1/.ssh/authorized_keys
sudo chmod 755 /home/vbc6u1
sudo chmod 700 /home/vbc6u1/.ssh
sudo chmod 600 /home/vbc6u1/.ssh/authorized_keys
sudo chown vbc6u1:vbc6u1 /home/vbc6u1/.ssh
sudo chown vbc6u1:vbc6u1 /home/vbc6u1/.ssh/authorized_keys

echo "Done creating vbc6u1 authorized_keys file.."
echo "Copy pub key to vbc6u2 .ssh directory from vagrant/provision directory"

sudo su vbc6u1
cd ~
cp /vagrant/provision/authorized_keys /home/vbc6u1/.ssh/authorized_keys
sudo su vagrant

echo "Finished updateing keys and files vbc6u1 .."
echo "Create vbc6u2 authorized_keys file"

sudo mkdir /home/vbc6u2/.ssh
sudo touch /home/vbc6u2/.ssh/authorized_keys
sudo chmod 755 /home/vbc6u2
sudo chmod 700 /home/vbc6u2/.ssh
sudo chmod 600 /home/vbc6u2/.ssh/authorized_keys
sudo chown vbc6u2:vbc6u2 /home/vbc6u2/.ssh
sudo chown vbc6u2:vbc6u2 /home/vbc6u2/.ssh/authorized_keys

echo "Done creating vbc6u2 authorized_keys file.."
echo "Copy pub key to vbc6u2 .ssh directory from vagrant/provision directory"

sudo su vbc6u2
cd ~
cp /vagrant/provision/authorized_keys /home/vbc6u2/.ssh/authorized_keys
sudo su vagrant


echo "Done installing ssh keys.."
echo "Install telnet"

sudo yum install telnet -y

echo "Done installing telnet"
echo "Save a copy of iptables current configuration"

sudo /sbin/iptables-save > /tmp/iptables_bu

echo "Done saving copy of iptables"
echo "Create new ftp user ula-vsftp"

sudo /usr/sbin/useradd -c "VSFTP User" -G wheel ula-vsftp

echo "Change ula-vsftp user shell to /bin/noshell"

sudo /usr/sbin/usermod -s /sbin/nologin ula-vsftp

echo "Backup existing iptables configuration file."

sudo cp /etc/sysconfig/iptables-config /etc/sysconfig/iptables-config_bu

echo "Check iptables status"

echo sudo /sbin/service iptables status

echo "Edit telnet config under /etc/xinetd.d/"
echo "Lab Six b -- "
echo "Install ftp -- vsftpd"

sudo yum install vsftpd -y
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf_bu
sudo /sbin/service vsftpd status

echo "Done installing vsftp -- update vsftpd.conf later."
echo "Check /etc/vsftpd/vsftp.conf"
echo "Create /etc/vsftpd/vsftpd-userlist.txt."

sudo touch /etc/vsftpd/vsftpd-userlist.txt
sudo echo "ula-vsftp" > /etc/vsftpd/vsftpd-userlist.txt

echo "Done creating vsftp user list file."
echo "Start the vsftpd service"

sudo /sbin/service vsftpd start

echo "Done starting vsftp service"
echo "Open Port 21 for FTP request"

sudo /sbin/iptables -I INPUT -s 192.168.33.10/24 -p tcp --dport 21 -j ACCEPT

echo "Port 21 open"
echo "Backup named.conf file"

sudo cp /etc/named.conf /etc/named.conf_bu

echo "Replace original named.conf with contents of cach_named.txt"

echo "Do this one in another script"
echo "Update named.conf and restart named"
echo "Add firewall rules for named"

sudo iptables -I INPUT 2 -p udp --dport 53 -j ACCEPT
sudo iptables -I INPUT 2 -p tcp --dport 53 -j ACCEPT

echo "Firewall rules updated"
echo "Update host DNS nameserver"
echo "Backup /etc/resolv.conf "

sudo cp /etc/resolv.conf /etc/resolv.conf_bu

echo "Backup of /etc/resolv.conf complete"
echo "Add a nameserver 127.0.0.1 line to the resolv.conf file."

cp /vagrant/provision/resolv.conf /etc/resolv.conf

echo "/etc/resolv.conf updated"
echo "Restart network service when done updating "

sudo service network restart

echo "Network restarted .."
echo "Check for access to files under /var/named "

sudo ls -ali /var/named

echo "Done with named for now "
echo "Add Development Tools to the machine"

sudo yum groupinstall "Development Tools"
sudo yum install xz
sudo yum install bzip2

echo "Done with first cut at Q1 provisioning"
