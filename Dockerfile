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
      net-tools \
      mysql-client \
      netcat \
      nmap \
      postgresql-client \
      tree \
      vim \
      wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN pip3 install -U pip

# Install pip modules
RUN pip3 install kubernetes pycodestyle pylint yamllint awscli reckoner

# Install latest ASDF
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf \
        && cd ~/.asdf \
        && git checkout "$(git describe --abbrev=0 --tags)"

RUN echo ". $HOME/.asdf/asdf.sh" > ~/.bashrc

COPY tool-versions /.tool-versions

# Use Bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Add Plugins
RUN source ~/.bashrc; for plugin in $(cat /.tool-versions | awk '{print $1}'); do asdf plugin add $plugin; done

ENTRYPOINT /bin/bash
