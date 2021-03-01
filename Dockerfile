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

RUN adduser --shell /bin/bash --home /asdf --disabled-password asdf
ENV HOME=/asdf
ENV PATH="${PATH}:/asdf/.asdf/shims:/asdf/.asdf/bin"

USER asdf
RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf && \
    cd $HOME/.asdf && \
    git checkout "$(git describe --abbrev=0 --tags)" && \
    echo '. $HOME/.asdf/asdf.sh' >> $HOME/.bashrc && \
    echo '. $HOME/.asdf/asdf.sh' >> $HOME/.profile

ADD tool-versions $HOME/.tool-versions
RUN for p in $(cat $HOME/.tool-versions | awk '{print $1}'); do asdf plugin add $p; done
RUN asdf install
