# -*- mode: ruby -*-
# vi: set ft=ruby :

if ! File.exists?('./resources/NDP452-KB2901907-x86-x64-AllOS-ENU.exe')
  puts '.Net 4.5.2 installer could not be found!'
  puts "Please run:\n  wget http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe"
  exit 1
end

if ! File.exists?('./resources/Octopus.Tentacle.2.6.0.778-x64.msi')
  puts 'Octopus Tentacle installer could not be found!'
  puts "Please run:\n  wget http://download.octopusdeploy.com/octopus/Octopus.2.6.0.778-x64.msi"
  exit 1
end

Vagrant.configure(2) do |config|

  config.vm.box = "ferventcoder/win2008r2-x64-nocm"
  config.vm.guest = :windows
  config.vm.communicator = "winrm"

  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true

  config.vm.provision :shell, path: "scripts/install-iis.cmd"
  config.vm.provision :shell, path: "scripts/delete-default-iis-website.ps1"
  config.vm.provision :shell, path: "scripts/install-dot-net.ps1"
  config.vm.provision :shell, path: "scripts/install-dot-net-45.cmd"
  config.vm.provision :shell, path: "scripts/install-octopus-tentacle.cmd"
  config.vm.provision :shell, path: "scripts/configure-octopus-tentacle.cmd"

  config.vm.boot_timeout = 600

  config.vm.define "dev" do |dev|
    dev.vm.network "private_network", ip: "192.168.100.10"
    dev.vm.host_name = "phoenix.dev"
  end

  config.vm.define "fat" do |fat|
    fat.vm.network "private_network", ip: "192.168.100.11"
    fat.vm.host_name = "phoenix.fat"
  end

  config.vm.define "sat" do |sat|
    sat.vm.network "private_network", ip: "192.168.100.12"
    sat.vm.host_name = "phoenix.sat"
  end

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
    
    # Customize the amount of memory on the VM:
    vb.cpus = 2
    vb.memory = 2048
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"
end
