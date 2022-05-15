set -eux
set -o pipefail

sudo dnf install -y virtualbox-guest-additions
sudo dnf group install -y gnome
# not sure if these were necessary
sudo systemctl enable gdm.service
sudo systemctl set-default graphical.target
# auto login as vagrant user
# partially untested
if ! grep -Fxq 'AutomaticLoginEnable=True' /etc/gdm/custom.conf; then
    sudo sed -i 's/^\[daemon]$/[daemon]\nAutomaticLoginEnable=True\nAutomaticLogin=vagrant\n/' /etc/gdm/custom.conf
fi

sudo dnf group install -y gnome c-development gnome-software-development
sudo dnf install -y \
     meson \
     gjs-devel \
     mutter-devel \
     polkit-devel \
     startup-notification-devel \
     ibus-devel \
     pipewire-devel \
     NetworkManager-libnm-devel \
     rust-libpulse-sys+pa_v12-devel \
     gtk4-devel \
     gnome-autoar-devel \
     sassc \
     asciidoc

mkdir -p src/gnome-shell/build
cd src/gnome-shell/build
meson --buildtype=debug --prefix=/usr ..
ninja
sudo ninja install
