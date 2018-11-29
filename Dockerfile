FROM alpine:latest

ENV HOME=/
ENV VAULT_VERSION="0.11.4"

RUN apk add --update \
  curl \
  postgresql-client \
  ca-certificates \
  git \
  net-tools \
  libffi-dev \
  musl-dev \
  gcc \
  nmap \
  openssl-dev \
  python \
  python-dev \
  py-pip \
  tcpdump \
  iputils \
  bind-tools \
  mysql-client \
  netcat-openbsd \
  vim \
  jq \
  bash \
  bash-completion \
  iptables \
  openssh-client \
  openssl

RUN pip install -U pip

# Install pip modules
RUN pip install kubernetes

# Install latest kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl

# Install latest kops
RUN curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 \
  && chmod +x kops-linux-amd64 \
  && mv kops-linux-amd64 /usr/local/bin/kops

# Install latest helm
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh \
  && chmod 700 get_helm.sh \
  && ./get_helm.sh

# Install vault (Specified version above)
RUN curl -LO https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
  && unzip vault_${VAULT_VERSION}_linux_amd64.zip \
  && rm vault_${VAULT_VERSION}_linux_amd64.zip \
  && chmod +x vault \
  && mv vault /usr/local/bin/vault
