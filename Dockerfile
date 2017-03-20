FROM debian:latest

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  postgresql \
  git \
  net-tools \
  tcpdump \
  dstat \
  dnsutils \
  && rm -rf /var/lib/apt/lists/*
