# Three node kubernetes cluster on Fedora

This repo has scripts and required artifacts to start a three node Kubernetes cluster on Fedora based machines using kubeadm.

## Prerequisite

* Vagrant
* Libvirt
* git

## Setup

Boot machines using following commands:

```bash
git clone https://github.com/surajssd/kubeadm-on-fedora
cd kubeadm-on-fedora
vagrant up
```

Once the machines are up run following commands, all in different tabs:

```bash
vagrant ssh c0 -c "sudo /vagrant/master.bash"
vagrant ssh w0 -c "sudo /vagrant/worker.bash"
vagrant ssh w1 -c "sudo /vagrant/worker.bash"
```

Once all the machines are up and running follow the output commands from the `c0` machine for the cluster to be complete. To access cluster run following commands:

```bash
vagrant ssh c0
```

```
[vagrant@c0 ~]$ kubectl get nodes
NAME   STATUS   ROLES    AGE     VERSION
c0     Ready    master   3m58s   v1.15.0
w0     Ready    <none>   2m9s    v1.15.0
w1     Ready    <none>   2m17s   v1.15.0
```
