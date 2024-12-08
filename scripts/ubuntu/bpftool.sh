#!/bin/bash

apt install -y curl
arch=$(uname -m)
bpftool_version=v7.2.0
if [[ "$arch" == "aarch64" ]]; then
  arch=arm64;
elif [[ "$arch" == "x86_64" ]]; then
  arch=amd64;
fi
curl -LO https://github.com/libbpf/bpftool/releases/download/"$bpftool_version"/bpftool-"$bpftool_version"-"$arch".tar.gz && \
    tar -xzf bpftool-"$bpftool_version"-"$arch".tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/bpftool

. /etc/os-release

# install libbpf-dev
if [ "$VERSION_CODENAME" == "jammy" ]; then
    apt-get -y install libbpf-dev
fi