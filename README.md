## DevStack with Vagrant!

### Step 1: Install Vagrant and Friends
Vagrant uses VirtualBox to handle creation of the actual virtual machines. Head over to [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads) to find the appropriate installer for your system.

If you're running Mac OS X, you must also install Xcode. Users running Lion can can install Xcode through the App Store. You can also grab the installer from [http://developer.apple.com/xcode/](http://developer.apple.com/xcode/).

Once you've got VirtualBox and Xcode installed, you're ready to install Vagrant. The [official recommendation](http://docs.vagrantup.com/v2/installation/index.html) is to install Vagrant using builds from [http://downloads.vagrantup.com/](http://downloads.vagrantup.com/), so grab the latest and install it.

Also you'll probably need to install [NFS](http://en.wikipedia.org/wiki/Network_File_System) on your computer to work with this project. Mac OS X has it by default, but running on Linux will require ```nfs-kernel-server``` installation.

NOTE: This project is intended to work with Vagrant v1.3.2

### Step 2: Check Out the Code
Now would be a good time to actually check out the project :

    git clone http://github.com/bcwaldon/vagrant_devstack.git

The project has submodules for other recipes:

    git submodule init
    git submodule update

### Step 3: Configuration
You can set up a local yaml-formatted config file to override the default settings used with the project. Place your config file at `etc/vagrant.yaml` or set a custom location in the environment variable `VD_CONF`. See a sample config at `etc/vagrant.yaml.sample`.

DevStack itself allows you to define a `localrc` file. This file is injected into your environment and sourced before the environment is built. You can use this to override settings such as `MYSQL_PASSWORD` or `NOVA_REPO`. See http://devstack.org for more information. If you decide to create your own localrc file, place it at `etc/localrc` file or set the `VD_LOCALRC` environment variable to its location.

### Step 4: Execution
At this point you can run `vagrant up` and ssh into your DevStack environment!
