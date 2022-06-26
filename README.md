## My home Minikube cluster configs

This repo contains some development / learning work I've done to deploy several applications on my home network.

### K8s clusters

#### Create

You can create a Minikube cluster in KVM on your ZFS array by running

```shell
$ yarn cluster:create
```

Update the `ZFS_MOUNTPOINT` environment variable in `[scripts/start-new.sh](scripts/start-new.sh) to your target dataset's mountpoint.

#### Delete

Delete your Minikube cluster with

```shell
$ yarn cluster:delete
```
