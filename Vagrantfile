# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  config.vm.define "c0" do |c0|
    c0.vm.box = "fedora/30-cloud-base"
    c0.vm.hostname = "c0"
  end


  config.vm.define "w0" do |w0|
    w0.vm.box = "fedora/30-cloud-base"
    w0.vm.hostname = "w0"
  end


  config.vm.define "w1" do |w1|
    w1.vm.box = "fedora/30-cloud-base"
    w1.vm.hostname = "w1"
  end


  config.vm.provider "libvirt" do |libvirt, override|
    libvirt.driver = "kvm"
    libvirt.memory = 4000
    libvirt.cpus = 3
    libvirt.cpu_mode = 'host-passthrough'
  end

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    echo '127.0.0.1 localhost' | cat - /etc/hosts > temp && sudo mv temp /etc/hosts
  SHELL

end
