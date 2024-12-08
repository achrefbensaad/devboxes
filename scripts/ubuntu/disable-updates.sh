#!/bin/sh -eux
#https://github.com/boxcutter/kvm/blob/main/ubuntu/cloud/scripts/disable-updates.sh
export DEBIAN_FRONTEND=noninteractive

echo "==> Disable systemd apt timers/services"
systemctl stop apt-daily.timer;
systemctl stop apt-daily-upgrade.timer;
systemctl disable apt-daily.timer;
systemctl disable apt-daily-upgrade.timer;
systemctl mask apt-daily.service;
systemctl mask apt-daily-upgrade.service;
systemctl daemon-reload;

# Disable periodic activities of apt to be safe
cat <<EOF >/etc/apt/apt.conf.d/10periodic;
APT::Periodic::Enable "0";
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
APT::Periodic::Unattended-Upgrade "0";
EOF

# Disable snapd updates
echo "==> Disable snap updates"
systemctl stop snapd.service;
systemctl stop snapd.socket;
systemctl mask snapd.service;
systemctl mask snapd.socket;

echo "==> Remove the unattended-upgrades and ubuntu-release-upgrader-core packages"
apt-get -y purge unattended-upgrades ubuntu-release-upgrader-core;
rm -rf /var/log/unattended-upgrades;

echo "==> Disable pro features"
#https://gist.github.com/jfeilbach/f4d0b19df82e04bea8f10cdd5945a4ff
pro config set apt_news=false
rm /var/lib/update-notifier/updates-available
systemctl disable ubuntu-advantage
mv -v /etc/apt/apt.conf.d/20apt-esm-hook.conf /etc/apt/apt.conf.d/20apt-esm-hook.conf.disabled
touch /etc/apt/apt.conf.d/20apt-esm-hook.conf
apt-get  --assume-yes  --purge remove ubuntu-advantage-tools
systemctl mask apt-news.service
systemctl mask esm-cache.service

