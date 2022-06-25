#! /bin/bash
# Start my minikube cluster.

if ! hash xmlstarlet 2>/dev/null; then
    _error "Must install xmlstarlet dependency for inline XML updates to virsh templates."
fi

export ZFS_MOUNTPOINT=/homePool/home/VMs/general

minikube start --interactive=false \
               --kubernetes-version=1.24.1 \
               --install-addons=true \
               --cpus=2 \
               --driver=kvm2 \
               --kvm-network=default \
               --memory=6g \
               --nodes=3 \
               --disk-size=20g \
               --extra-disks=0 \
               --dns-domain=cluster.local \
               --service-cluster-ip-range='10.96.0.0/16' \
               --nat-nic-type=virtio \
               --namespace=default \
               --disable-metrics=false \
               --wait-timeout=3m0s \
minikube addons enable metrics-server
minikube status

printf "\\nMigrating kvm disks to ZFS mountpoint.\\n\\n"

# Due to a bug that was not fixed (not sure if it will ever be), I need a hacky work-around for migrating minikube virtual disks
# from the minikube home directory to my ZFS array.
./stop.sh
sudo mv "${MINIKUBE_HOME:-$HOME/.minikube}"/machines/minikube* "$ZFS_MOUNTPOINT"

mapfile -t VMs < <(virsh list --all --name | grep -i minikube)

for VM in "${VMs[@]}"; do
    printf "Updating devices for %s.\\n" "$VM"
    virsh dumpxml --security-info "$VM" > ".${VM}.xml"    
done
