## Creating a Kubernetes cluster on DigitalOcean:

For the most trivial cluster, you need at least two servers for this playbook to work. The kubernetes.io example application is actually kind of beefy, so I recommend four servers. You also need them to be at least 2GB RAM. (If you do 1GB, that will technically "work", but remember that Kubernetes does not guarantee *where* the containers get scheduled to run. So if things deploy in a lop-sided way with one node having a disproportionately large number of the containers, you'll hit the physical memory limit, thrash and hit swap. You'll really hate life on 1GB.) The setup I am doing is actually 4x 4GB servers. It costs about $0.25 an hour to run, so like, when you're testing this yourself don't go crazy and leave the cluster up for like a day, as it will get expensive **real** fast. So, with your hosts:

```
k8s-1.uwsg.tech #Primary
k8s-2.uwsg.tech #Secondary
k8s-3.uwsg.tech #Secondary
k8s-4.uwsg.tech #Secondary
```

Just run this one command:

```bash
ansible-playbook cluster.yml
```

After ages and ages, you will end up with:

```bash
sudo root@k8s-1.uwsg.tech
sudo -iu nonprivileged
kubectl get nodes
```

You should be able to see

```
nonprivileged@k8s-1:~$ kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
k8s-1     Ready     master    2m        v1.8.2
k8s-2     Ready     <none>    1m        v1.8.2
k8s-3     Ready     <none>    1m        v1.8.2
k8s-4     Ready     <none>    1m        v1.8.2
```

Keep in mind the nodes may take up to 90 seconds to report "Ready".
