## Home Minikube cluster configs

This repo contains some development / learning work I've done to deploy several applications on my home network.

### K8s clusters

#### Create

You can create a Minikube cluster in KVM on your ZFS array by running

```shell
$ yarn cluster:create
```

This command can take several minutes to complete.

```shell

```

Update the `ZFS_MOUNTPOINT` environment variable in [scripts/start-new.sh](scripts/start-new.sh) to your target dataset's mountpoint. I've defaulted it to a particular data set on my array.

#### Delete

Delete your Minikube cluster with

```shell
$ yarn cluster:delete
```

This deletes your cluster in Minikube's configs, removes vdisks from the ZFS mountpoint, and undefines any residual VMs prefixed with `minikube`.
