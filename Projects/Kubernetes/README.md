## Creating a Kubernetes cluster on DigitalOcean:

### If you want to play with this yourself

- Create or use your own domain.
- Install Terraform, Python, and Jinja2 for python.
- Pick a number of servers desired.
- Edit hosts file to change 1:n to the desired number.
- Edit render-cluster-configuration.py. Change lines 6 and 7 as desired (host count must match).
- Change the hardcoded string in roles/kubernetes/tasks/main.yml (Line 64)
- Make sure you SSH into each server first so you know you can connect and you validated the SSH host key.
- In the infrastructure directory, run ```./apply.sh```
- From this directory (Kubernetes), run ```ansible-playbook cluster.yml```

### Discussion

For the most trivial cluster, you need at least two servers for this playbook to work. The kubernetes.io example application is actually kind of beefy, so I recommend four servers. You also need them to be at least 2GB RAM. (If you do 1GB, that will technically "work", but remember that Kubernetes does not guarantee *where* the containers get scheduled to run. So if things deploy in a lop-sided way with one node having a disproportionately large number of the containers, you'll hit the physical memory limit, thrash and hit swap. You'll really hate life on 1GB.) The setup I am doing is actually 4x 4GB servers. It costs about $0.25 an hour to run, so like, when you're testing this yourself don't go crazy and leave the cluster up for like a day, as it will get expensive **real** fast.

Run the playbook:

```bash
ansible-playbook cluster.yml
```

It takes considerable time to run as the Kubernetes packages and Docker images from Google Cloud take a while to download. After all that completes, you should be able to log into the primary and verify the cluster status:

```bash
sudo root@k8s-1.uwsg.tech
sudo -iu nonprivileged
kubectl get nodes
```

After 90 seconds, you should be able to see this:

```
nonprivileged@k8s-1:~$ kubectl get nodes
NAME      STATUS    ROLES     AGE       VERSION
k8s-1     Ready     master    2m        v1.8.2
k8s-2     Ready     <none>    1m        v1.8.2
k8s-3     Ready     <none>    1m        v1.8.2
k8s-4     Ready     <none>    1m        v1.8.2
```

If you check any sooner than 48 seconds, there is 0% chance that all the nodes will be ready.
