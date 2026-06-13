#!/bin/bash

set -ouex pipefail

# add necessary system packages
# add fedora-repos-ostree to enable rebasing back to silverblue
# remove firefox - use from flathub
dnf5 install -y fedora-repos-ostree tailscale vim gvfs-nfs syncthing
dnf5 remove -y firefox

echo -e "[Daemon]\nAutomaticUpdatePolicy=stage" > /etc/rpm-ostreed.conf

# enable tailscale and auto updates
systemctl enable tailscaled.service
systemctl enable rpm-ostreed-automatic.timer
