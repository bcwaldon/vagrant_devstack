
# Override these values with a local config defined in VD_CONF
conf = {
    'ip_prefix' => '192.168.2',
    'devstack_branch' => "master",
    'ip_suffix' => 100,
    'mac_prefix' => '080027002',
    'box_name' => 'precise64',
    'box_url' => 'http://files.vagrantup.com/precise32.box',
    'allocate_memory' => 1024,
    'cache_dir' => 'cache/',
    'ssh_dir' => '~/.ssh/',
    'devstack_floating_range' => '128/28',
    'devstack_cookbooks_dir' => 'cookbooks',
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

Vagrant::Config.run do |config|
  config.vm.box = conf['box_name']
  config.vm.box_url = conf['box_url']

  memory = conf['allocate_memory'].to_s()
  config.vm.customize ["modifyvm", :id, "--memory", memory]
  devstackbranch = conf['devstack_branch'] 
  config.vm.host_name = devstackbranch.split('/').last

  suffix = conf['ip_suffix']

  ip_prefix = conf['ip_prefix']
  ip = "#{ip_prefix}.#{suffix}"
  range = conf['devstack_floating_range']

  mac_prefix = conf['mac_prefix']
  mac = "#{mac_prefix}#{suffix}"

  Vagrant::Config.run do |config|
    config.vm.network(:hostonly, ip, :mac => mac)
  end

  cache_dir = conf['cache_dir']
  config.vm.share_folder("v-cache", "/home/vagrant/cache", cache_dir,
                         :nfs => true)

  ssh_dir = conf['ssh_dir']
  config.vm.share_folder("v-ssh", "/home/vagrant/.host-ssh", ssh_dir)

  port_fwd = (8000 + suffix)
  config.vm.forward_port 80, port_fwd 

  cookbooks_dir = conf['devstack_cookbooks_dir']
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = cookbooks_dir
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
          :floating_range => "#{ip_prefix}.#{range}",
          :instances_path => "/home/vagrant/instances", # Quick workaround, for stack.sh cleanup for instances causing deletion of /home/vagrant/ in the midddle of the install
          :branch => devstackbranch,
          :host_ip => ip,
          :localrc => localrc
      },
    })
  end
end
