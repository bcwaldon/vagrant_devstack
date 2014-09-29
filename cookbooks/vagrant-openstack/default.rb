#
# Cookbook Name:: nova
# Attributes:: default
#
# Copyright 2008-2009, Opscode, Inc.
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

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

default[:nova][:hostname] = "nova"
default[:nova][:install_type] = "binary"
default[:nova][:compute_connection_type] = "qemu"
default[:nova][:creds][:user] = "nova"
default[:nova][:creds][:group] = "nogroup"
default[:nova][:creds][:dir] = "/var/lib/nova"
default[:nova][:my_ip] = ipaddress
default[:nova][:vlan_interface] = "eth1"
default[:nova][:flatdhcp] = true
default[:nova][:flat_interface] = "eth1"
default[:nova][:public_interface] = "br100"
default[:nova][:mysql] = true
default[:nova][:images] = []
default[:nova][:floating_range] = "192.168.76.128/28"
default[:nova][:fixed_range] = "10.0.0.0/8"
default[:nova][:flat_dhcp_start] = "10.0.0.2"
default[:nova][:num_networks] = 8
default[:nova][:network_size] = 32
default[:nova][:user] = "admin"
default[:nova][:project] = "admin"
set_unless[:nova][:access_key] = secure_password
set_unless[:nova][:secret_key] = secure_password
