#
# Cookbook Name:: vagrant-openstack
# Recipe:: cache
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

d = node['cache']['dir']
u = node['user']

execute "rm -rf /var/cache/apt; mkdir -p #{d}/aptcache; ln -s #{d}/aptcache /var/cache/apt"

execute "mkdir -p #{d}/pipcache; ln -s #{d}/pipcache /var/cache/pip" do
  not_if { File.directory?("/var/cache/pip") }
end

execute "ln -s /home/#{u}/.host-ssh/id_rsa /home/#{u}/.ssh/id_rsa" do
    user u
    group u
    not_if { File.exists?("/home/#{u}/.ssh/id_rsa") }
end

