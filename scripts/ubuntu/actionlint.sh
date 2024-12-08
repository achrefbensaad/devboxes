#!/bin/bash

repo=rhysd/actionlint
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

VERSION=$(get_latest_release $repo | sed -E "s/^v//" )
TMP_DIR=$(mktemp -d)
pushd "$TMP_DIR" || exit 1
wget https://github.com/rhysd/actionlint/releases/download/v"$VERSION"/actionlint_"$VERSION"_linux_amd64.tar.gz
tar xf actionlint_"$VERSION"_linux_amd64.tar.gz
mv actionlint /bin/
popd || exit 1
rm "$TMP_DIR" -rf