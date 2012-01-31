## DevStack with Vagrant!

### Step 1: Install Vagrant
This project officially supports Vagrant v0.9.3, but should work with any v0.9.X releases.

### Step 2: Check Out Cookbooks
You will need a local copy of the `openstack-cookbooks` project. You can find these at cloudbuilders/openstack-cookbooks

### Step 3: Configuration
You can set up a local config file to override the default settings used with the project. See a sample config in `etc/vagrant.yaml.sample`. Place your own copy at `etc/vagrant.yaml`, or set a custom location in the environment variable `VD_CONF`.

DevStack allows you to define a custom `localrc` file, which is essentially a bash script that gets sourced before the environment is built. You should use this to override settings such as the `MYSQL_PASSWORD` or the `NOVA_REPO`. You can create an `etc/localrc` file, or point to a custom loation with `VD_LOCALRC`.

### Step 4: Execution
At this point you can run `vagrant up` and ssh into your DevStack environment!
