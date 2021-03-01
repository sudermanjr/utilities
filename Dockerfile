FROM ubuntu:20.04

ENV HOME=/
ENV TMPDIR=/tmp
ENV TZ=Etc/GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV VAULT_VERSION="1.6.3"
ENV TERRAFORM_VERSION="0.13.6"

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y -qq \
      curl \
      dnsutils \
      python3 python3-pip python3-dev \
      git \
      jq \
      net-tools \
      mysql-client \
      netcat \
      nmap \
      postgresql-client \
      tree \
      vim \
      wget \
      unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip

# Install pip modules
RUN pip3 install kubernetes pycodestyle pylint yamllint awscli reckoner

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

# Install yq
RUN curl -LO https://github.com/mikefarah/yq/releases/download/4.0.0/yq_linux_amd64 \
  && mv yq_linux_amd64 /usr/local/bin/yq \
  && chmod +x /usr/local/bin/yq

# Install Argo
RUN curl -sSL -o /usr/local/bin/argo https://github.com/argoproj/argo/releases/download/v2.2.1/argo-linux-amd64 \
  && chmod +x /usr/local/bin/argo

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && chmod +x terraform \
  && mv terraform /usr/local/bin/terraform \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
# Install vault (Specified version above)
RUN curl -LO https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
  && unzip vault_${VAULT_VERSION}_linux_amd64.zip \
  && rm vault_${VAULT_VERSION}_linux_amd64.zip \
  && chmod +x vault \
  && mv vault /usr/local/bin/vault

# Install yq
RUN curl -LO https://github.com/mikefarah/yq/releases/download/4.0.0/yq_linux_amd64 \
  && mv yq_linux_amd64 /usr/local/bin/yq \
  && chmod +x /usr/local/bin/yq

# Install Argo
RUN curl -sSL -o /usr/local/bin/argo https://github.com/argoproj/argo/releases/download/v2.2.1/argo-linux-amd64 \
  && chmod +x /usr/local/bin/argo

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && chmod +x terraform \
  && mv terraform /usr/local/bin/terraform \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
