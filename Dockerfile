FROM debian:latest

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  postgresql-client \
  git \
  net-tools \
  tcpdump \
  dstat \
  dnsutils \
  mysql-client \
  vim \
  && rm -rf /var/lib/apt/lists/*
