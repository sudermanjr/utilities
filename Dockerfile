FROM alpine:latest

RUN apk add --update=yes \
    curl \
    postgresql-client \
    wget \
    git \
    net-tools \
    tcpdump \
    mysql-client \
    vim \
    jq \ 
    && rm -rf /var/cache/apk/*
RUN curl -L https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz|tar -xzv -C /usr/local/bin/
