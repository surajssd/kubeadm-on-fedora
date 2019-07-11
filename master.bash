#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

setup_fedora_machine
kubeadm init --pod-network-cidr=192.168.0.0/16
