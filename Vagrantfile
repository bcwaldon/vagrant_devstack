
# Override these values with a local config defined in VD_CONF
conf = {
    'ip_prefix' => '192.168.27',
    'box_name' => 'trusty',
    'box_url' => 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box',
    'allocate_memory' => 4096,
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

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

vd_localconf = ENV.fetch('VD_LOCALCONF', 'etc/local.conf')
if File.exist?(vd_localconf)
    localconf = IO.read(vd_localconf)
else
    localconf = ''
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = conf['box_name']
  config.vm.box_url = conf['box_url']

  config.vm.provider :virtualbox do |v|
    v.name = conf['box_name']

    memory = conf['allocate_memory'].to_s()
    v.customize ["modifyvm", :id, "--memory", memory]

    n_cpus = conf['num_cpus']
    v.customize ["modifyvm", :id, "--cpus", n_cpus.to_s()] if ! n_cpus.nil?
    v.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
  end

  ip_prefix = conf['ip_prefix']
  ip = "192.168.33.2"

  # Management network
  config.vm.network :private_network, ip:ip
  # VM network
  config.vm.network :private_network, ip:"#{ip_prefix}.2"

  cache_dir = conf['cache_dir']
  config.vm.synced_folder(cache_dir, "/home/vagrant/cache", id: "v-cache", create: true)
  
  ssh_dir = conf['ssh_dir']
  config.vm.synced_folder(ssh_dir, "/home/vagrant/.host-ssh", id: "v-ssh", create: true)

  config.vm.provision "shell",
    inline: "echo 'APT::Cache-Start 50000000;' > /etc/apt/apt.conf"

  cookbooks_dir = conf['devstack_cookbooks_dir']
  config.vm.provision :chef_solo do |chef|
    chef.arguments = "--chef-license accept" 
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
          :flat_interface => "eth2",
          :public_interface => "eth2",
          :floating_range => "#{ip_prefix}.0/24",
          :instances_path => "/home/vagrant/instances", # Quick workaround, for stack.sh cleanup for instances causing deletion of /home/vagrant/ in the midddle of the install
          :host_ip => ip,
          :localconf => localconf,
          :repository => conf['devstack_repo'],
          :gateway_ip => "#{ip_prefix}.2",
          :branch => conf['devstack_branch']
      },
    })
  end
end
