This project is created from a GitLab [Project Template](https://docs.gitlab.com/ce/gitlab-basics/create-project.html)

Additions and changes to the project can be proposed [on the original project](https://gitlab.com/gitlab-org/project-templates/express)

The main project content associated with an ebook library is taken from:
https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs/Introduction


### After Cloning Repository

## Linux Instructions

Make sure you have the latest versions Node and npm installed on your computer.
How to install the latest version of npm and node
```
$ sudo apt-get install python-software-properties
$ curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
```
Long term support version are:
```
$ sudo apt-get install python-software-properties
$ curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```
See your distribution's documentation for installing packages.

Next, install MongoDB server. Alternatively, you can run a MongoDB container:

```
docker pull mongo
docker run -d --name ebook_mongo -p 27017:27017 mongo
```

Then run the following commands for one-time setup:

```
npm install
node populatedb.js mongodb://localhost/local_library
DEBUG=demo:* npm run start
```
## Vagrant with VirturalBox Instructions

Tested with Vagrant 2.0.0 and VirturalBox 5.1.28

Create a working directory on your local machine.

Copy the Vagrantfile listed next into the working directory:

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.network "forwarded_port", guest: 80, host: 8087, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3000, host: 3333, host_ip: "127.0.0.1"

   config.vm.synced_folder "./", "/home/vagrant/code"
end
```
Next in the same directory as the Vagrantfile clone the repository.

```
git clone git@uwsg.tech:ebooks/node_ebooks.git
```
Next bring up the VirturalBox VM.

```
vagrant up
```
Now ssh into the VM.

```
vagrant ssh
```

Next update code package manager.

```
sudo apt update
```

Now install latest versions of node and npm.

```
$ sudo apt-get install python-software-properties
$ curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

sudo apt-get install nodejs
```
Check node and npm versions.

```
node --version
npm --version
```
Change directory to code installation.

```
cd ../vagrant/code/node_ebooks
```

Install node modules.

```
npm install
```
Install mongoDB.

```
sudo apt install mongodb-server
```
Put test data into database.

```
node populatedb.js mongodb://localhost/local_library
```

Start the express web service.

```
npm run start
```
Open a browser to 127.0.0.1:3333/catalog to interact with the web page.
