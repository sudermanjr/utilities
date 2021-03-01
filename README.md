# Utilities

Contains a lot of utilities that I use on a regular basis.

## ASDF

There are several tools that are installed using [asdf](https://asdf-vm.com/#/). This enables you to easily install a different version at runtime if desired.

See the [tool-versions](/tool-versions) for the default versions installed.

## Other Packages

See the [Dockerfile](/Dockerfile) for the full list of installed packages. Some are listed here:

* curl
* postgresql-client
* git
* net-tools
* nmap
* dnsutils
* mysql-client
* vim
* jq
* iptables
* openssl

## Kubernetes Deployment

There is a simple deployment definition yaml file that will add this to your kube cluster for diagnosing issues inside the cluster.

### Unprivileged - standard

Use this for 99% of cases, especially network and DNS troubleshooting.  This deployment is safe, and will not allow excess privilege escalation or access.

[utility-deploy.yaml](utility-deploy.yaml)

### Privileged - BUYER BEWARE

This image has every permission that I can think to add.  This is only ever used in cases where access to the node is infeasible and I am forced to run a container to access node-level resources, including the docker socket.  Please don't do this unless you really know what you're doing.

[utility-deploy-privileged.yaml](utility-deploy-privileged.yaml)
