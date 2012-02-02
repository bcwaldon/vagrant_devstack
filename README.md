## DevStack with Vagrant!

### Step 1: Install Vagrant
This project officially supports Vagrant v0.9.3, but should work with any v0.9.X releases.

### Step 2: Check Out Cookbooks
You will need a local copy of the `devstack_cookbooks` project: 

`git clone http://github.com/bcwaldon/devstack_cookbooks`

### Step 3: Set up a Box
This project depends on having an Ubuntu 11.10 box available in VirtualBox with the Guest Additions already installed. Run the following command to download a safe base box and make it availble under the name 'oneiric':

`vagrant box add oneiric http://images.ansolabs.com/vagrant/oneiric64.box`

If your box has a different name than 'oneiric', make sure you set the `box_name` attribute in your config file.

### Step 4: Configuration
You can set up a local config file to override the default settings used with the project. See a sample config in `etc/vagrant.yaml.sample`. Place your own copy at `etc/vagrant.yaml`, or set a custom location in the environment variable `VD_CONF`. Ensure you set `devstack_cookbooks_dir` to point to the proper directory. The default location is `./devstack_cookbooks`.

DevStack also allows you to define a `localrc` file. This file will be injected into your environmant and sourced before the environment is built. You can use this to override settings such as `MYSQL_PASSWORD` or `NOVA_REPO`. See http://devstack.org for more information. You can create an `etc/localrc` file, or point to a custom loation with `VD_LOCALRC`.

### Step 5: Execution
At this point you can run `vagrant up` and ssh into your DevStack environment!
