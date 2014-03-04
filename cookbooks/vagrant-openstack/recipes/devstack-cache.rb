#
# Cookbook Name:: vagrant-openstack
# Recipe:: devstack-cache
#
# Copyright (c) 2012, OpenStack, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"

package 'rsync'

d = node['cache']['dir']
u = node['user']

execute "mkdir -p #{d}/stack; rsync -vur --delete --exclude=stack/nova-volumes-backing-file --exclude=stack/glance/images/* #{d}/stack /opt; chown -R #{u} /opt/stack"
