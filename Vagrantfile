# -*- mode: ruby -*-
# vi: set ft=ruby :

$provision = <<EOF
export BUILD_NUMBER=#{ENV['BUILD_NUMBER']}
apt-get update
apt-get -y upgrade
apt-get -y install autoconf libtool automake gettext
apt-get -y install ruby ruby-dev rubygems
apt-get -y install git
apt-get -y install mono-gmcs
gem update
gem install fpm --no-ri --no-rdoc
cd ~vagrant
export PATH=/var/lib/gems/1.8/bin:$PATH
sh /vagrant/build-mono-package.bash "$1"
mkdir -p /vagrant/`lsb_release --codename --short`
cp *.deb /vagrant/`lsb_release --codename --short`
EOF

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "wheezy" do |wheezy|
    wheezy.vm.box = "debian-wheezy-x64-7digital"
    wheezy.vm.provision "shell", inline: $provision, args: "#{ENV['MONO_VERSION']}"
  end

  config.vm.define "squeeze" do |squeeze|
    squeeze.vm.box = "debian-squeeze-x64-7digital"
    squeeze.vm.provision "shell", inline: $provision, args: "#{ENV['MONO_VERSION']}"
  end
end
