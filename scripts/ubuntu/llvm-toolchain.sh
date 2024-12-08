#!/bin/bash

. /etc/os-release
apt-get -y install build-essential libelf-dev pkg-config net-tools linux-headers-"$(uname -r)" linux-tools-"$(uname -r)"
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
if [ "$VERSION_CODENAME" == "focal" ] || [ "$VERSION_CODENAME" == "bionic" ]; then
    sudo ./llvm.sh 12
    for tool in "clang" "llc" "llvm-strip" "opt" "llvm-dis"; do
        sudo rm -f /usr/bin/$tool
        sudo ln -s /usr/bin/$tool-12 /usr/bin/$tool
    done
else # VERSION_CODENAME == jammy
    sudo ./llvm.sh 14
    for tool in "clang" "llc" "llvm-strip" "opt" "llvm-dis"; do
        sudo rm -f /usr/bin/$tool
        sudo ln -s /usr/bin/$tool-14 /usr/bin/$tool
    done
fi

rm llvm.sh