#!/bin/bash

GO_VERSION=$(curl -Ls https://go.dev/VERSION?m=text | head -n 1)
DOWNLOAD_URL="https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz" # for linux
wget "${DOWNLOAD_URL}"
rm -rf /usr/local/go && tar -C /usr/local -xzf "${GO_VERSION}.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin" >> /home/vagrant/.bashrc
