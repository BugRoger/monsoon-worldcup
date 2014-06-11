$setup = <<SCRIPT
apt-get install jq

# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Build containers from Dockerfiles
docker build -t postgres /monsoon-worldcup/docker/postgres
docker build -t rails    /monsoon-worldcup

# Run and link the containers
docker run -d -v /var/lib/postgresql:/data -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker --name postgres postgres:latest
docker run -d -v /monsoon-worldcup:/monsoon-worldcup -p 3000:3000 --link postgres:db --name rails rails:latest
SCRIPT

$start = <<SCRIPT
docker start postgres
docker start rails
SCRIPT

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ENV['http_proxy']  || ENV['HTTP_PROXY']
    config.proxy.https    = ENV['https_proxy'] || ENV['HTTPS_PROXY']
    config.proxy.ftp      = ENV['ftp_proxy']   || ENV['FTP_PROXY']
    config.proxy.no_proxy = ENV['no_proxy']    || ENV['NO_PROXY']
  end

  # Setup resource requirements
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.customize ["modifyvm", :id, 
      "--natdnshostresolver1", "off",
      "--natdnsproxy1", "off"
    ]
  end

  # need a private network for NFS shares to work
  config.vm.network "private_network", type: "dhcp" 

  # Rails Server Port Forwarding
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Ubuntu
  config.vm.box = "ubuntu/trusty64"

  # Install latest docker
  config.vm.provision "docker"

  # Must use NFS for this otherwise rails
  # performance will be awful
  config.vm.synced_folder ".", "/monsoon-worldcup", type: "nfs"

  # Setup the containers when the VM is first
  # created
  config.vm.provision "shell", inline: $setup

  ## Make sure the correct containers are running
  ## every time we start the VM.
  config.vm.provision "shell", run: "always", inline: $start
end
