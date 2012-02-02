#
# Cookbook Name:: anso
# Recipe:: settings
#
# Copyright 2011, Anso Labs
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

d = node['cache']['dir']
u = node['cache']['user']

execute "rm -rf /var/cache/apt; mkdir -p #{d}/aptcache; ln -s #{d}/aptcache /var/cache/apt"

execute "mkdir -p #{d}/pipcache; ln -s #{d}/pipcache /var/cache/pip" do
  not_if { File.directory?("/var/cache/pip") }
end

execute "mkdir -p #{d}/stack; ln -s #{d}/stack /opt/stack" do
  only_if { File.directory?("#{d}/stack") }
  not_if { File.directory?("/opt/stack") }
end

