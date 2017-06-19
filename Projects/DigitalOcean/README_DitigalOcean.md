# Ubuntu 16.04 OS Setup

Be sure to add your public key to the authorized_keys file so you can
ssh in from a terminal.  Ubuntu does not allow root password login from
ssh by default.

### Setup new user [DONE]

$ adduser newuser_name  // add a new user

$ usermod -aG sudo newuser_name  // add new user to the sudo group

$ sudo visudo // edit sudoers file
              // remove password requirement for sudoers group

$ su - newuser_name              

$ mkdir .ssh // make a .ssh directory for keys

$ chmod 700 .ssh // change permissions on .ssh directory

$ cd .ssh

$ touch authorized_keys // make empty authorized_keys file

$ chmod 600 authorized_keys // change permissions on authorized_keys file

// copy public key into authorized_keys file



### Setup second user [DONE]

// use the setup new user steps above

### Setup NGINX [DONE]

$ sudo apt-get update

$ sudo apt-get install nginx

// open at least three termainal sessions to the server
// use both user accounts ..

$ sudo ufw app list // check firewall

$ sudo ufw allow 'Nginx HTTP'

$ sudo ufw status // check firewall status

// if the firewall is inactive it will need to be activated
// it is important to make sure that you also allow ssh
// on port 22 over tcp along with HTTP on port 80

$ sudo ufw allow ssh // or sudo ufw allow 22/tcp

// make sure you can ssh into the machine
// if necessary enable ufw

$ sudo ufw enable

// check to make sure you can ssh into the machine from
// one of the other open terminal sessions.



### Work web pages with Javascript [TO DO]
