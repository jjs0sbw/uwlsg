# GitLab

## How to use

You need to have the following:

1. [Ansible](https://docs.ansible.com/ansible/latest/intro_installation.html) installed on your machine.
2. [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
3. An [API Personal Access Token](https://cloud.digitalocean.com/settings/api/tokens) on your Digital Ocean account.
4. An [SSH key](https://cloud.digitalocean.com/settings/security) on your Digital Ocean account.

        #Here is how you create an SSH key
        ssh-keygen -t ed25519

## What you need to do before running this

1. Clone this repository.
2. Copy your API key from Digital Ocean and put it into an environment variable called DO_PAT.
3. Run get-ssh-keys.sh to get the SSH key ID(s) from Digital Ocean.
4. Place those into the gitlab.tf file (line 7)
5. Replace all instances of the domain "uwsg.tech" with some other test domain. (If you do not want to register a domain, you can change your /etc/hosts file to accommodate a testing use case.)
        
        roles/gitlab/vars/main.yml
        roles/gitlab/tasks/main.yml
        vars.tf
        gitlab.tf
        hosts
6. If you haven't already make sure your system-level (/etc/ansible/ansible.cfg) or user-level (~/.ansible.cfg) file contains a line telling Ansible where you want to get your SSH private key from so you can authenticate to your Digital Ocean droplets. This is extremely important!

        private_key_file = ~/.ssh/id_ed25519

## To run the scripts

    ./apply.sh
    ansible-playbook playbook.yml

## Outstanding issues

1. Need to make the SSH keys populate in the Terraform file dynamically using *only* the API key without any manual copying and pasting requried.
2. Need to centralize how the domain is specified so it's not sprawled out throughout all these files.
