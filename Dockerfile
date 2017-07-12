FROM debian:latest

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  postgresql-client \
  git \
  net-tools \
  tcpdump \
  traceroute \
  dstat \
  dnsutils \
  mysql-client \
  vim \
  jq \
  && rm -rf /var/lib/apt/lists/*

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/\
  $(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl

RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh \
  && chmod 700 get_helm.sh \
  && ./get_helm.sh
