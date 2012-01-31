
# Override these values with a local config defined in VD_CONF
conf = {
    'ip_prefix' => '192.168.27',
    'mac_prefix' => '080027027',
    'box_name' => 'oneiric',
    'allocate_memory' => 1024,
    'openstack_cookbooks_dir' => 'openstack-cookbooks/',
    'cache_dir' => 'cache/',
    'ssh_dir' => '~/.ssh/',
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

  memory = conf['allocate_memory'].to_s()
  config.vm.customize ["modifyvm", :id, "--memory", memory]

  suffix = "100"

  ip_prefix = conf['ip_prefix']
  ip = "#{ip_prefix}.#{suffix}"

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

  cookbooks_dir = conf['openstack_cookbooks_dir'] 
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "#{cookbooks_dir}/cookbooks"
    chef.roles_path = "#{cookbooks_dir}/roles"
    chef.log_level = :debug
    chef.run_list = [
      "recipe[anso::cache]",
      "recipe[nova::hostname]",
      "recipe[nova::source]",
    ]
    chef.json.merge!({
      :nova => {
        :source => {
          :localrc => localrc
        }
      },
    })
  end
end
