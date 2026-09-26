#!/bin/bash

set -ouex pipefail

# add necessary system packages
# add fedora-repos-ostree to enable rebasing back to silverblue
# remove firefox - use from flathub
dnf5 install -y fedora-repos-ostree tailscale gvfs-nfs syncthing gnome-tweaks
dnf5 remove -y firefox
dnf5 clean all

echo -e "[Daemon]\nAutomaticUpdatePolicy=stage" > /etc/rpm-ostreed.conf

mkdir -p /etc/firefox/policies/ /var/lib/flatpak/extension/org.mozilla.firefox.systemconfig/$(uname -m)/stable/policies/
cp /ctx/firefox-policies.json /etc/firefox/policies/policies.json /var/lib/flatpak/extension/org.mozilla.firefox.systemconfig/$(uname -m)/stable/policies/policies.json

# enable tailscale and auto updates
systemctl enable tailscaled.service
systemctl enable rpm-ostreed-automatic.timer
systemctl enable update-flatpaks.timer
