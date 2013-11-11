
# Override these values with a local config defined in VD_CONF
conf = {
    'ip_prefix' => '192.168.27',
    'mac_prefix' => '080027027',
    'box_name' => 'precise',
    'box_url' => 'http://files.vagrantup.com/precise64.box',
    'allocate_memory' => 1024,
    'cache_dir' => 'cache/',
    'ssh_dir' => '~/.ssh/',
    'devstack_repo' => 'git://github.com/openstack-dev/devstack.git',
    'devstack_branch' => 'master',
}


vd_conf = ENV.fetch('VD_CONF', 'etc/vagrant.yaml')
if File.exist?(vd_conf)
    require 'yaml'
    user_conf = YAML.load_file(vd_conf)
    conf.update(user_conf)
end

vd_localrc = ENV.fetch('VD_LOCALRC', 'etc/localrc')
if File.exist?(vd_localrc)
    localrc = IO.read(vd_localrc)
else
    localrc = ''
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = conf['box_name']
  config.vm.box_url = conf['box_url']

  config.vm.provider :virtualbox do |v|
    v.name = conf['box_name']

    memory = conf['allocate_memory'].to_s()
    v.customize ["modifyvm", :id, "--memory", memory]

    n_cpus = conf['num_cpus']
    v.customize ["modifyvm", :id, "--cpus", n_cpus.to_s()] if ! n_cpus.nil?
  end

  suffix = "100"

  ip_prefix = conf['ip_prefix']
  ip = "#{ip_prefix}.#{suffix}"

  mac_prefix = conf['mac_prefix']
  mac = "#{mac_prefix}#{suffix}"

  config.vm.network :private_network, ip: ip, mac: mac

  cache_dir = conf['cache_dir']
  config.vm.synced_folder(cache_dir, "/home/vagrant/cache", id: "v-cache", create: true, nfs: true)
  
  ssh_dir = conf['ssh_dir']
  config.vm.synced_folder(ssh_dir, "/home/vagrant/.host-ssh", id: "v-ssh", create: true)

  config.vm.provision "shell",
    inline: "echo 'APT::Cache-Start 50000000;' > /etc/apt/apt.conf"

  cookbooks_dir = conf['devstack_cookbooks_dir']
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.log_level = :debug
    chef.run_list = [
      "recipe[vagrant-openstack::hostname]",
      "recipe[vagrant-openstack::cache]",
      "recipe[vagrant-openstack::devstack-cache]",
      "recipe[devstack]",
      "recipe[vagrant-openstack::devstack-update-cache]",
      #"recipe[vagrant-openstack::dotfiles]",
    ]
    chef.json.merge!({
      :my_ip => ip,
      :devstack => {
          :flat_interface => "eth1",
          :public_interface => "eth1",
          :floating_range => "#{ip_prefix}.128/28",
          :instances_path => "/home/vagrant/instances", # Quick workaround, for stack.sh cleanup for instances causing deletion of /home/vagrant/ in the midddle of the install
          :host_ip => ip,
          :localrc => localrc,
          :repository => conf['devstack_repo'],
          :branch => conf['devstack_branch']
      },
    })
  end
end
