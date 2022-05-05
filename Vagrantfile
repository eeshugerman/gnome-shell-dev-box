# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "fedora/35-cloud-base"  # fedora/36-beta-cloud-base 404s

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "../gnome-shell", "/src/gnome-shell"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "1024"


    # keyboard/mouse input doesn't work without this
    vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    set -ux
    set -o pipefail

    dnf group install -y gnome gnome-software-development
    dnf install -y \
      virtualbox-guest-additions \
      meson \
      gjs # wah


    ## auto login as vagrant user
    # not sure if these were necessary
    systemctl enable gdm.service
    systemctl set-default graphical.target
    # TODO: skip if already present
    sed -i 's/^\\[daemon]$/[daemon]\\nAutomaticLoginEnable=True\\nAutomaticLogin=vagrant\\n/' /etc/gdm/custom.conf

    # sudo reboot

    ## alternatively, don't boot to graphical. may not be needed on fresh provision.
    # haven't figured out how to start gnome session from ssh (either x or wayland) so this is useless for now.
    # systemctl set-default multi-user.target


    # https://unix.stackexchange.com/questions/137440/how-to-open-fedora-without-a-user-password
  SHELL

  # config.trigger.after [:provision] do |t|
  #   t.name = "Reboot after provisioning"
  #   t.run = { :inline => "vagrant reload" }
  # end

end
