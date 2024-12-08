#!/bin/bash

repo=k0sproject/k0sctl
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

wget https://github.com/k0sproject/k0sctl/releases/download/$(get_latest_release $repo)/k0sctl-linux-amd64
chmod +x k0sctl-linux-amd64
mv k0sctl-linux-amd64 /bin/k0sctl