FROM alpine:latest 

ENV HOME=/
ENV KUBE_VERSION="1.5.2"
ENV KOPS_VERISON="1.6.1"
ENV HELM_VERSION="2.5.0"

RUN apk add --update \
  wget \
  curl \
  postgresql-client \
  git \
  net-tools \
  tcpdump \
  iputils \
  bind-tools \
  mysql-client \
  vim \
  jq \
  bash \
  bash-completion 

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/linux/amd64/kubectl \
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
  && rm -rf linux-amd64 \
