FROM ubuntu:20.04

ENV HOME=/
ENV TMPDIR=/tmp
ENV TZ=Etc/GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y -qq \
      curl \
      dnsutils \
      python3 python3-pip python3-dev \
      git \
      jq \
      kubectl \
      net-tools \
      mysql-client \
      netcat \
      nmap \
      postgresql-client \
      terraform \
      tree \
      vim \
      wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip

# Install pip modules
RUN pip3 install kubernetes pycodestyle pylint yamllint awscli reckoner
