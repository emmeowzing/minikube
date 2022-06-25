#! /bin/bash

minikube delete

export ZFS_MOUNTPOINT=/homePool/home/VMs/general

sudo rm -rf "${ZFS_MOUNTPOINT:?}/"*

mapfile -t VMs < <(virsh list --all --name | grep -i minikube)

for VM in "${VMs[@]}"; do
    virsh undefine "$VM"
done
