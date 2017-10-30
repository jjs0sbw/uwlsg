## Creating a Kubernetes cluster on DigitalOcean:

You need to control the following hosts:

- ```k8s-n.uwsg.tech``` (where ```n``` is some host number)

```bash
ansible-playbook cluster.yml
ansible-playbook leader.yml
```
