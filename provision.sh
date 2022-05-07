set -eux
set -o pipefail

dnf group install -y gnome gnome-software-development
dnf install -y virtualbox-guest-additions meson


## auto login as vagrant user
# not sure if these were necessary
systemctl enable gdm.service
systemctl set-default graphical.target
# TODO: skip if already present
sed -i 's/^\\[daemon]$/[daemon]\\nAutomaticLoginEnable=True\\nAutomaticLogin=vagrant\\n/' /etc/gdm/custom.conf


## alternatively, don't boot to graphical. may not be needed on fresh provision.
# haven't figured out how to start gnome session from ssh (either x or wayland) so this is useless for now.
# systemctl set-default multi-user.target

# based on https://gitlab.gnome.org/GNOME/gnome-shell/-/snippets/1515
gnome_libs='gsettings-desktop-schemas libgweather gjs glib mutter'
freedesktop_libs='pipewire'

sudo chown $USER $HOME/src

for lib in $gnome_libs; do
    lib_dir="$HOME/src/$lib"
    if [ -d $lib_dir ]; then
        cd $lib_dir
        git pull
    else
        git clone "https://gitlab.gnome.org/GNOME/$lib" $lib_dir
        cd $lib_dir
    fi
    meson --prefix=/usr build
    sudo ninja -C build install -j1
done
