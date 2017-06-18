# Ubuntu 16.04 OS Setup

Be sure to add your public key to the authorized_keys file so you can
ssh in from a terminal.  Ubuntu does not allow root password login from
ssh by default.

### Setup new user [DONE]

$ adduser newuser_name  // add a new user

$ usermod -aG sudo newuser_name  // add new user to the sudo group

$ sudo visudo // edit sudoers file
              // remove password requirement for sudoers group

$ mkdir .ssh // make a .ssh directory for keys

$ chmod 700 .ssh // change permissions on .ssh directory

$ cd .ssh

$ touch authorized_keys // make empty authorized_keys file

$ chmod 600 authorized_keys // change permissions on authorized_keys file

// copy public key into authorized_keys file



### Setup second user [TO DO]

### Setup NGINX [DONE]

### Work web pages with Javascript [TO DO]
