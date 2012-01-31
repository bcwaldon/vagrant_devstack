## DevStack with Vagrant!

### Step 1: Install Vagrant
This project officially supports Vagrant v0.9.3, but should work with any v0.9.X releases.

### Step 2: Check Out Cookbooks
You will need a local copy of the `openstack-cookbooks` project. You can find these at http://github.com/cloudbuilders/openstack-cookbooks

### Step 3: Configuration
You can set up a local config file to override the default settings used with the project. See a sample config in `etc/vagrant.yaml.sample`. Place your own copy at `etc/vagrant.yaml`, or set a custom location in the environment variable `VD_CONF`. Ensure you set `cookbooks_dir` to point to the proper directory. The default location it checks is `./openstack-cookbooks`.

DevStack depends on having an Ubuntu 11.10 box available in VirtualBox with the Guest Additions already installed. Once you add your Oneiric box, make sure you set the `box_name` attribute in your config file if it differs from the default of `oneiric`.

DevStack also allows you to define a `localrc` file. This file will be injected into your environmant and sourced before the environment is built. You can use this to override settings such as `MYSQL_PASSWORD` or `NOVA_REPO`. See http://devstack.org for more information. You can create an `etc/localrc` file, or point to a custom loation with `VD_LOCALRC`.

### Step 4: Execution
At this point you can run `vagrant up` and ssh into your DevStack environment!
