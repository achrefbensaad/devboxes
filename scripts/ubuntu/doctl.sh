#!/bin/bash

repo=digitalocean/doctl
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

VERSION=$(get_latest_release $repo | sed -E "s/^v//" )

apt install -y wget
wget https://github.com/digitalocean/doctl/releases/download/v"$VERSION"/doctl-"$VERSION"-linux-amd64.tar.gz
tar xf doctl-"$VERSION"-linux-amd64.tar.gz
mv doctl /usr/local/bin
rm doctl-"$VERSION"-linux-amd64.tar.gz