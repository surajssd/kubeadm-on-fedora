#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

readonly root=$(dirname "${BASH_SOURCE[0]}")

# shellcheck source=/dev/null
source "${root}/common.bash"

function copy_kubeconfig() {
  mkdir -p "${1}"/.kube
  cp -i /etc/kubernetes/admin.conf "${1}"/.kube/config
  chmod a+rw -R "${1}"/.kube/
}

setup_fedora_machine
kubeadm init --pod-network-cidr=192.168.0.0/16
copy_kubeconfig "/root"
copy_kubeconfig "/home/vagrant"

# setup networking
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

# instructions for workers to join master
echo "Run following command on workers:"
join_cmd="sudo $(kubeadm token create --print-join-command)"
echo "vagrant ssh w0 -c \"${join_cmd}\""
echo "vagrant ssh w1 -c \"${join_cmd}\""
