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

### Set up domain name and DNS records [DONE]

// used Cheap-Domain Registration for two names
// -- conceptsystem.us
// -- conceptsystems.info

// Set up name servers at registration site
// Set up A record and CNAME record at Digital Ocean
// www.conceptsystem.us now works ..

### Add Security Certificate to nginx server [TO DO]
// install certbot
// first add the repository

$ sudo add-apt-repository ppa:certbot/certbot

$ sudo apt-get update

$ sudo apt-get install certbot

// now use webroot to obtain a SSL certificate
// webroot places a special file /.well-known
// in web document root

// now edit /etc/nginx/sites-available/default

sudo vi /etc/nginx/sites-available/default

// inside the SSL server block -- add a location block

  location ~ /.well-known {
           allow all;
  }

 // check document root location

  /var/www/html

// check nginx configuration for syntax errors

$ sudo nginx -t

// restart nginx

sudo systemctl restart nginx

// now request a SSL Certificate

$ sudo certbot certonly --webroot --webroot-path=/var/www/html -d conceptsystem.us -d www.conceptsystem.us

// first time -- enter email and accept terms of service

Output
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at
   /etc/letsencrypt/live/example.com/fullchain.pem. Your cert
   will expire on 2017-07-26. To obtain a new or tweaked version of
   this certificate in the future, simply run certbot again. To
   non-interactively renew *all* of your certificates, run "certbot
   renew"
 - If you lose your account credentials, you can recover through
   e-mails sent to sammy@example.com.
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le

   // check files exist

   $ sudo ls -l /etc/letsencrypt/live/conceptsystem.us

   // generate a strong Diffie-Hellman group

   $ sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

   // check at

   /etc/ssl/certs/dhparam.pem

   // configure nginx

   // 1- create a configuration snippet containing SSL key and file locations

   $ sudo vi /etc/nginx/snippets/ssl-conceptsystem.us.configuration

   // file content

   ssl_certificate /etc/letsencrypt/live/conceptsystem.us/fulchain.pem
   ssl_certificate_key /etc/letsencrypt/live/conceptsystem.us/privkey.pem


   // 2- create a configuration snippet containing strong SSL settings that can be used with any certificate in the future

   $ sudo vi /etc/nginx/snippets/ssl-params.conf

   // file content

   (comment out) from https://cipherli.st/                            
   (comment out) https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
ssl_ecdh_curve secp384r1;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
// (comment out) disable HSTS header for now
// (comment out) add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;

ssl_dhparam /etc/ssl/certs/dhparam.pem;


   // 3-adjust nginx server block to handle SSL requests and use the two snippets above.

   // this configuration assumes the use of the default server block in the
   // /etc/nginx/sites-available directory

   // backup existing server block file








### Work web pages with Javascript [TO DO]
