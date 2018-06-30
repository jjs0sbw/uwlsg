# Study: Compute Datacenter with Security Focus

This project is a study on setting up a Nomad datacenter which is backed by a private certificate authority. The main focus of the project is to build the datacenter with two objectives: strong security fundamentals and easy scalability. Highlights include the usage of mutual TLS at all levels of the stack, and the ability to scale out horizontally simply by changing counts in the main Terraform file. This setup is capable of running microservices through the Docker runtime and exposes public services to the internet dynamically through HAProxy and Consul Template.

## Required software

- cfssl (TLS PKI tool by Cloudflare)
- Terraform (Infrastructure provisioning tool by Hashicorp)
- Ansible (Configuration management tool by Ansible Inc., now under Red Hat Inc.)
- Python 3
- OpenSSL

## Optional software

- Vagrant (Development environment provisioning tool by Hashicorp)

## Directions (DigitalOcean)

1. **Create an API access token** To run this datacenter in the public cloud, you will need a DigitalOcean account. The Terraform specification runs nine 2GB RAM hosts, so it costs $0.20 per hour, or $4.75 per day. From the DigitalOcean dashboard, you will need to create an API access token with read and write capabilities. You will need to copy that key to your clipboard and place it into a new Terraform file located at ```terraform/do_token.tf```. The contents of the file should be as follows:

```
variable "do_token" {
  default = "<YOUR API ACCESS TOKEN HERE>"
}
```

:red_circle: This file is extremely sensitive, and its public disclosure would be catastrophic, resulting in anything from other people running expensive cryptocurrency mining workloads at your expense, or even destruction of your existing resources. A read/write API access token provides a user not only with the ability to create and destroy droplets but also to insert their own SSH keys into the authorized hosts file. The probability of these events is all but guaranteed. Open source offensive security tools such as [gitrob](https://github.com/michenriksen/gitrob) are used by low-sophistication users on a regular basis to carry out these kinds of attacks.

2. **Create an Ansible Vault password file**

Create a file called ```pwd.txt``` which contains a password for Ansible Vault to use for encryption of secret variables. This file can contain any suitably secure passphrase and then a newline.

3. **Create group_vars/all/secrets.yml**

```ansible-vault create group_vars/all/secrets.yml```

This file needs to contain gossip keys for Consul and Nomad respectively, as well as a shared secret key for Cloudflare SSL. The gossip keys are used by Consul and Nomad to communicate membership and cluster state over a secure channel. Because this protocol takes place over UDP, TLS is not available, and we need to use pre-shared symmetric keys for securing the gossip communication. The CA shared key is used by ```cfssl``` to authenticate clients which are attempting to obtain TLS certificates for the first time. Because I run the CA publicly, I need a way to prevent unauthorized clients from obtaining TLS certificates and joining the cluster as trusted hosts.

Place something like the following content into this file:

```
consul_gossip_key: daieWROxeBs4KLWV4AEDWA==
nomad_gossip_key: l4fqucDNLg9OIViMsWTznQ==
ca_shared_key: 34ebe20f67ffaef907179d04526cc9e6
```

The gossip keys can be generated using ```openssl rand -base64 16``` and the CA shared key can be generated using ```openssl rand -hex 16```.

4. **Set the domain variable in Terraform**

In ```terraform/vars.tf``` change the value of the ```domain``` variable to a domain that you own. The variable is found in at the top of the file in a section that looks like this:

```
variable "domain" {
  default = "adriennecohea.ninja" # <- Change this value
}
```

5. **Create the certificate authority root**

Run ```init_ca.sh``` which will create the private key and TLS certificate for the root of the PKI. It will also copy these files to the Ansible ```ca``` role folder so that that key material will be provisioned when the infrastructure is created.

6. **Create the infrastructure**

Run the ```start.sh``` script to kick off the primary tasks of creating the infrastructure in DigitalOcean using Terraform and running the provisioning and configuration using Ansible.

7. **Destroy the infrastructure when finished**

Run the ```destroy.sh``` script to discard the infrastructure after you are finished using it to avoid incurring charges.
