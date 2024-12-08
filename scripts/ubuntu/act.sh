#!/bin/bash

apt install -y wget

repo=nektos/act
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

VERSION=$(get_latest_release $repo)
TMP_DIR=$(mktemp -d)
pushd "$TMP_DIR" || exit 1
wget https://github.com/nektos/act/releases/download/"$VERSION"/act_Linux_x86_64.tar.gz
tar xf act_Linux_x86_64.tar.gz
mv act /bin/
popd || exit 1
rm "$TMP_DIR" -rf