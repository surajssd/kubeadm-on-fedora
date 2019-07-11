#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

function setup_fedora_machine() {
  # Set SELinux in permissive mode (effectively disabling it)
  setenforce 0
  sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

  # it is required that for kubelet to function the swap should be off
  swapoff -a

  # install docker from fedora 29
  sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install -y --releasever=29 docker-ce docker-ce-cli containerd.io
  systemctl enable --now docker

  # add the google's yum repo
  cat <<EOF >/etc/yum.repos.d/kubernetes.repo
  [kubernetes]
  name=Kubernetes
  baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
  enabled=1
  gpgcheck=1
  repo_gpgcheck=1
  gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
  yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

  # enable routing
  cat <<EOF >/etc/sysctl.d/k8s.conf
  net.bridge.bridge-nf-call-ip6tables = 1
  net.bridge.bridge-nf-call-iptables = 1
EOF
  sysctl --system

  # load this module
  modprobe br_netfilter

  # start kubelet
  systemctl daemon-reload
  systemctl enable --now kubelet
  systemctl status kubelet
}
