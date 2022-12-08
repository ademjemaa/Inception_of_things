# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "adjemaa" do |adjemaa|
    adjemaa.vm.box = "centos/7"
    adjemaa.vm.hostname = "server"
    adjemaa.vm.network "private_network", ip: "192.168.42.110", virtualbox__intnet: "eth1"
    adjemaa.vm.provider "virtualbox" do |vb|
      vb.name = "adjemaa"
    end
    adjemaa.vm.provision "file", source: "id_rsa", destination: "~/.ssh/id_rsa"
    adjemaa.vm.provision "file", source: "id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    adjemaa.vm.provision "shell", path: "k3s-install-server.sh"
  end

  config.vm.define "adjemaa-worker" do |adjemaa_worker|
    adjemaa_worker.vm.box = "centos/7"
    adjemaa_worker.vm.hostname = "serverworker"
    adjemaa_worker.vm.network "private_network", ip: "192.168.42.111", virtualbox__intnet: "eth1"
    adjemaa_worker.vm.provider "virtualbox" do |vb|
      vb.name = "adjemaa-worker"
    end
    adjemaa_worker.vm.provision "file", source: "id_rsa", destination: "~/.ssh/id_rsa"
    adjemaa_worker.vm.provision "file", source: "id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
    adjemaa_worker.vm.provision "shell", path: "k3s-install-agent.sh"
  end
end

