#!/bin/bash -e

# A POSIX variable
OPTIND=1 # Reset in case getopts has been used previously in the shell.

while getopts "a:v:q:u:d:" opt; do
    case "$opt" in
    a)  ARCH=$OPTARG
        ;;
    v)  VERSION=$OPTARG
        ;;
    q)  QEMU_ARCH=$OPTARG
        ;;
    u)  QEMU_VER=$OPTARG
        ;;
    d)  DOCKER_REPO=$OPTARG
        ;;
    t)  TAG_ARCH=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

TMP=tmp
ROOTFS=rootfs

# add qemu-user-static binary
if [ -n "${QEMU_ARCH}" ]; then
    cat >> Dockerfile <<EOF
# Add qemu-user-static binary for amd64 builders
ADD x86_64_qemu-${QEMU_ARCH}-static.tar.gz /usr/bin
EOF
fi

# build
docker build -t "${DOCKER_REPO}:${TAG_ARCH}-${VERSION}" .
docker run --rm "${DOCKER_REPO}:${TAG_ARCH}-${VERSION}" /bin/sh -ec "echo Hello from Alpine !; set -x; uname -a; cat /etc/alpine-release"
