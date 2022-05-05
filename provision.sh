set -ux
set -o pipefail

dnf group install -y gnome gnome-software-development
dnf install -y \
    virtualbox-guest-additions \
    meson \
    gjs # wah

# TODO: https://gitlab.gnome.org/GNOME/gnome-shell/-/snippets/1515

## auto login as vagrant user
# not sure if these were necessary
systemctl enable gdm.service
systemctl set-default graphical.target
# TODO: skip if already present
sed -i 's/^\\[daemon]$/[daemon]\\nAutomaticLoginEnable=True\\nAutomaticLogin=vagrant\\n/' /etc/gdm/custom.conf



## alternatively, don't boot to graphical. may not be needed on fresh provision.
# haven't figured out how to start gnome session from ssh (either x or wayland) so this is useless for now.
# systemctl set-default multi-user.target
