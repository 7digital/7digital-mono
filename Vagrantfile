# -*- mode: ruby -*-
# vi: set ft=ruby :

$provision = <<EOF
apt-get update
apt-get -y upgrade
apt-get -y install autoconf libtool automake gettext
apt-get -y install ruby ruby-dev rubygems
apt-get -y install git
apt-get -y install mono-gmcs
gem update
gem install fpm --no-ri --no-rdoc
cd ~vagrant
sh /vagrant/build-mono-package.bash "$1"
cp *.deb /vagrant
EOF

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian-wheezy-x64-7digital"
  config.vm.provision "shell", inline: $provision, args: "#{ENV['MONO_VERSION']}"
end
