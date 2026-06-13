#!/bin/bash

set -ouex pipefail

# add necessary system packages
# remove firefox - use from flathub
dnf5 install -y tailscale vim gvfs-nfs syncthing
dnf5 remove -y firefox

echo -e "[Daemon]\nAutomaticUpdatePolicy=stage" > /etc/rpm-ostreed.conf

# enable tailscale and auto updates
systemctl enable tailscaled.service
systemctl enable rpm-ostreed-automatic.timer
