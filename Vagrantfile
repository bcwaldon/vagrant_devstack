Vagrant::Config.run do |config|
  sshdir = "/Users/bcwaldon/.ssh/"
  cachedir = "/Users/bcwaldon/projects/vagrant/devstack/cache/"
  checkout = "/Users/bcwaldon/projects/openstack-cookbooks"
  ip_prefix = "192.168.27."
  mac_prefix = "080027027"
  suffix = "100"
  ip = "#{ip_prefix}#{suffix}"
  config.vm.box = "oneiric"
  config.vm.box_url = "http://images.ansolabs.com/vagrant/oneiric64.box"
  config.vm.customize do |vm|
    vm.memory_size = 2048
  end
  config.vm.network(ip, :mac => "#{mac_prefix}#{suffix}")
  config.vm.share_folder("v-cache", "/home/vagrant/cache", cachedir, :nfs => true)
  config.vm.share_folder("v-ssh", "/home/vagrant/.host-ssh", sshdir)
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "#{checkout}/cookbooks"
    chef.roles_path = "#{checkout}/roles"
    chef.log_level = :debug
    chef.run_list = [
      "recipe[anso::cache]",
      "recipe[nova::hostname]",
      "recipe[nova::source]",
      #"recipe[anso::settings]", # vim / screen / git settings for testing
    ]
    chef.json.merge!({
      :nova => {
        :source => {
          :mysql_password => "secrete",
          :rabbit_password => "secrete",
          :admin_password => "secrete",
          :service_token => "secrete",
          :flat_interface => "eth1",
          :public_interface => "eth1",
          :floating_range => "#{ip_prefix}128/28",
          :host_ip => ip,
          :nova_repo => "http://github.com/bcwaldon/nova.git",
          :nova_branch => "volume-policy"
#          :nova_repo => "https://review.openstack.org/p/openstack/nova",
#          :nova_branch => "refs/changes/43/2943/5"
        }
      },
    })
  end
end
