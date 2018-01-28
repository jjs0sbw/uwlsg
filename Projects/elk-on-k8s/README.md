# ELK on k8s

## Instructions

Start with a local Kubernetes cluster that has at least 4 GiB of RAM.

```
minikube start --memory 4096
```

Create all of the Kubernetes objects in the cluster.

```
./start.sh
```

Ensure that your hosts file contains an entry mapping the ```minikube ip``` IPv4 address to the hostname ```kibana.app.io```. For example

```
192.168.99.100 kibana.app.io
```

## Observations

The memory utilization when all the deployments are fully operational ends up being 84% of 3.8 GiB available. This is under no application load. Therefore it's reasonable that when scaled out properly, at least one of the nodes has to be 4 GiB, and no nodes should be less than 2 GiB. Otherwise, the cluster really can't do much of anything interesting. (For example, Redis and MongoDB, if they were run, would like to have very large amounts of memory, say 8-16 GiB or even 32 GiB in a high load production environment). The reason I stuck with 4096 MiB here was so that this could reasonably be run on someone's laptop in a coffee shop as a proof-of-concept.

Enjoy
