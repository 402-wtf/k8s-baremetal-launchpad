# k8s-baremetal-launchpad

This repo provides the base configuration for a cluster using Talos Linux and Sidero Metal on on-prem hardware.

This project is setup to optionally install:

* ArgoCD
* MetalLB
* Traefik

## Assumptions

* We assume the Kubernetes cluster has been setup outside of this setup.
* A kubeconfig should be accessible to this project prior.
* The running environment has access to the IP range that the Kubernetes cluster is running in.
* Terraform is installed in the running environment
* Some services in this setup are configured with HA in mind. 3 worker nodes may be required for some deployments to work correctly.

## Setup

The following environment variables need to be set:

`KUBE_CONFIG_PATH` - This is the path pointing to the kubeconfig for the cluster to be provisioned. An absolute path is referred.

# Running

```bash
terraform init
terraform plan -var-file configurations/<clustername>.tfvars
terraform apply -var-file configurations/<clutsername>.tfvars
```
