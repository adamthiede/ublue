#!/bin/bash

set -ouex pipefail

# install lowlevel network tool, basic editor, and a thing I need for accessing media
# remove firefox - use from flathub
dnf5 install -y tailscale vim gvfs-nfs
dnf5 remove -y firefox

echo -e "[Daemon]\nAutomaticUpdatePolicy=stage" > /etc/rpm-ostreed.conf

# enable tailscale and auto updates
systemctl enable tailscaled.service
systemctl enable rpm-ostreed-automatic.timer
