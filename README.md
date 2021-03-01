# Utilities

Contains the following utilities that are the latest version at build time:

### Custom Installs
* kubectl
* vault
* kops
* helm

### APK Packages
* curl
* postgresql-client
* git
* net-tools
* nmap
* tcpdump
* iputils
* bind-tools
* mysql-client
* vim
* jq
* bash
* bash-completion
* iptables
* openssh-client
* openssl

## Kubernetes Deployment

There is a simple deployment definition yaml file that will add this to your kube cluster for diagnosing issues inside the cluster.

### Unprivileged - standard

Use this for 99% of cases, especially network and DNS troubleshooting.  This deployment is safe, and will not allow excess privilege escalation or access.

[utility-deploy.yaml](utility-deploy.yaml)

### Privileged - BUYER BEWARE

This image has every permission that I can think to add.  This is only ever used in cases where access to the node is infeasible and I am forced to run a container to access node-level resources, including the docker socket.  Please don't do this unless you really know what you're doing.

[utility-deploy-privileged.yaml](utility-deploy-privileged.yaml)
