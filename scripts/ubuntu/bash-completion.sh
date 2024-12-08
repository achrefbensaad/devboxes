#!/bin/bash

apt install bash-completion -y
grep -wq '^source /etc/profile.d/bash_completion.sh' ~/.bashrc || echo 'source /etc/profile.d/bash_completion.sh'>>~/.bashrc
