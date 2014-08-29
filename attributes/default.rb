#
# Cookbook Name:: cornerstone-vagrant
# Attributes:: cornerstone-vagrant
#
# Copyright 2014,
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

include_attribute 'php-webserver'
include_attribute 'web-developer-cookbook'

# make sure we always listen on both 80 and 443 to avoid
# thrashing the port config and restarting apache all the time
node.default['apache']['listen_ports'] = [80, 443]
# turn extended status on
node.default['apache']['ext_status'] = true
# turn keepalive off
node.default['apache']['keepalive'] = 'Off'

# set apache group
node.default['cornerstone-vagrant']['www-user-group-name'] = 'www-user'
set['apache']['group'] = node['cornerstone-vagrant']['www-user-group-name']
node.default['apache']['group'] = node['cornerstone-vagrant']['www-user-group-name']

# What project are we deploying?
node.default['cornerstone-vagrant']['project'] = ''

# which configuration should be loaded?
node.default['cornerstone-vagrant']['environment'] = 'vagrant'

# the slug is used to determine things like vhost name and whatnot
# this is almost always the same as the project name
node.default['cornerstone-vagrant']['siteslug'] = node['cornerstone-vagrant']['project']

# give composer 20 minutes to finish in case
# there are any long running pre/post scripts etc..
node.default['cornerstone-vagrant']['composer-timeout'] = 1200

# Use this setting to add a custom git domain to your known hosts.
# E.G. 'www.mygitrepo.com'
# This will allow the recipe to compose repos from
# 'www.mygitrepo.com' without composer
# asking for user input to verify the RSA key.
node.default['cornerstone-vagrant']['known_host'] = ''

# Tools to install for developers
node.default['platform_packages']['pkgs'] = [
  {
    'name' => 'vim',
    'action' => 'install'
  },
  {
    'name' => 'dos2unix',
    'action' => 'install'
  },
  {
    'name' => 'wireshark',
    'action' => 'install'
  },
  {
    'name' => 'tshark',
    'action' => 'install'
  },
  {
    'name' => 'python-setuptools',
    'action' => 'install'
  },
  {
    'name' => 'python-dev',
    'action' => 'install'
  }
]
