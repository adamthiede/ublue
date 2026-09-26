#!/bin/bash

set -ouex pipefail

# add necessary system packages
# add fedora-repos-ostree to enable rebasing back to silverblue
# remove firefox - use from flathub
dnf5 install -y fedora-repos-ostree tailscale gvfs-nfs syncthing gnome-tweaks
dnf5 remove -y firefox
dnf5 clean all

# enable tailscale and auto updates
echo -e "[Daemon]\nAutomaticUpdatePolicy=stage" > /etc/rpm-ostreed.conf
systemctl enable tailscaled.service
systemctl enable rpm-ostreed-automatic.timer

# install firefox policies
mkdir -p /etc/firefox/policies/
cp /ctx/firefox-policies.json /etc/firefox/policies/policies.json

# install custom systemd services
cp /ctx/*.service /usr/lib/systemd/system/
cp /ctx/*.timer /usr/lib/systemd/system/
systemctl enable update-flatpaks.timer
systemctl enable firefox-policies.timer
