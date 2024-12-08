#!/bin/bash

repo=kubernetes-sigs/kubebuilder
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

VERSION=$(get_latest_release $repo )

wget --quiet https://github.com/kubernetes-sigs/kubebuilder/releases/download/"$VERSION"/kubebuilder_linux_amd64 -O kubebuilder
chmod +x kubebuilder
mv kubebuilder /usr/local/bin