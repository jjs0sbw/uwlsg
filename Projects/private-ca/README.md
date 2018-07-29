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

1. **Create an API access token** To run this datacenter in the public cloud, you will need a DigitalOcean account. The Terraform specification runs nine 2GB RAM hosts, so it costs $0.20 per hour, or $4.75 per day. From the DigitalOcean dashboard, you will need to create an API access token with read and write capabilities. You will need to copy that key to your clipboard and save it as an environment variable called ```DIGITALOCEAN_TOKEN```.

:red_circle: Never commit your DigitalOcean API access token to version control. This secret is extremely sensitive, and its public disclosure would be catastrophic, resulting in anything from other people running expensive cryptocurrency mining workloads at your expense, or even destruction of your existing resources. A read/write API access token provides a user not only with the ability to create and destroy droplets but also to insert their own SSH keys into the authorized hosts file. The probability of these events is all but guaranteed. Open source offensive security tools such as [gitrob](https://github.com/michenriksen/gitrob) are used by low-sophistication users on a regular basis to carry out these kinds of attacks.

2. **Set the domain variable in Terraform**

In ```terraform/vars.tf``` change the value of the ```domain``` variable to a domain that you own. The variable is found in at the top of the file in a section that looks like this:

```
variable "domain" {
  default = "<YOUR DOMAIN HERE>" # <- Change this value
}
```

3. **Create initial secrets**

Run ```init_secrets.sh``` which will create all of the secret key material required for the compute cluster.

There are three primary components: the certificate authority root, the shared key that will be introduced so that all VMs in the cluster can authenticate to the certificate authority and request a valid certificate, and the gossip keys that will be used by the Serf protocol for Consul and Nomad. The main CA root is placed in all VMs in the infrastructure as a common trust anchor. The other secrets stored in Ansible Vault are placed in ```group_vars/all/secrets.yml```. Because it is encrypted, it is safe to check into version control, although by default we do not. The contents of the file will look something like this:

```
consul_gossip_key: daieWROxeBs4KLWV4AEDWA==
nomad_gossip_key: l4fqucDNLg9OIViMsWTznQ==
ca_shared_key: 34ebe20f67ffaef907179d04526cc9e6
```


4. **Create the infrastructure**

Run the ```start.sh``` script to kick off the primary tasks of creating the infrastructure in DigitalOcean using Terraform and running the provisioning and configuration using Ansible.

5. **Start workloads on the cluster to verify its operation**

As an example, you can SSH to one of the ```control``` or ```compute``` VMs and copy the contents of ```examples/hello.nomad``` to a ```~/hello.nomad``` and then run ```nomad job run ~/hello.nomad```.

This particular example will run three instances of the ```tutum/hello-world``` container. After the Nomad clients download the Docker image for the first time, you should be able to verify that the backend servers appear in the loadbalancer.

Thus if you were to request loadbalancer.yourdomain.com in a browser, you will see that the hostname changes each time the page is refreshed. (This verifies that requests are being distributed in a round-robin fashion.)

6. **Destroy the infrastructure when finished**

Run the ```destroy.sh``` script to discard the infrastructure after you are finished using it to avoid incurring charges.
