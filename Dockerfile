FROM alpine:latest

ENV HOME=/
ENV KOPS_VERISON="1.7.0"
ENV HELM_VERSION="2.6.0"
ENV VAULT_VERSION="0.8.1"

RUN apk add --update \
  wget \
  curl \
  postgresql-client \
  git \
  net-tools \
  nmap \
  tcpdump \
  iputils \
  bind-tools \
  mysql-client \
  vim \
  jq \
  bash \
  bash-completion

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
      && chmod +x ./kubectl \
      && mv ./kubectl /usr/local/bin/kubectl \
      # Basic check it works.
      && kubectl version --client

# Install kops
RUN curl -LO https://github.com/kubernetes/kops/releases/download/$KOPS_VERISON/kops-linux-amd64 \
    && chmod +x kops-linux-amd64 \
    && mv kops-linux-amd64 /usr/local/bin/kops \
    && kops version

# Install helm
RUN curl -LO https://kubernetes-helm.storage.googleapis.com/helm-v$HELM_VERSION-linux-amd64.tar.gz \
  && tar -zxvf helm-v$HELM_VERSION-linux-amd64.tar.gz \
  && rm helm-v$HELM_VERSION-linux-amd64.tar.gz \
  && chmod +x linux-amd64/helm \
  && mv linux-amd64/helm /usr/local/bin/helm \
  && rm -rf linux-amd64

# Install vault
RUN curl -LO https://releases.hashicorp.com/vault/0.8.1/vault_$VAULT_VERSION_linux_amd64.zip \
  && unzip vault_$VAULT_VERSION_linux_amd64.zip \
  && rm vault_$VAULT_VERSION_linux_amd64.zip \
  && chmod +x vault \
  && mv vault /usr/local/bin/vault
