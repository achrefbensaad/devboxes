#!/bin/bash

apt install -y wget
wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb
apt install ./k9s_linux_amd64.deb -y
rm k9s_linux_amd64.deb