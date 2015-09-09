# NodeJS Development VM
# Requires Vagrant 1.7.2+

Vagrant.configure("2") do |config|

  config.vm.box = "Orgun109uk/NodeJS-64"

  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
  end

  config.vm.network "public_network"
  config.vm.network "private_network", ip: "192.168.200.100"
  config.vm.usable_port_range = (10200..10500)

  config.vm.provision :shell, path: "./scripts/startup.sh", run: "always"
end
