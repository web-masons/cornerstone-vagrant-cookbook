Cornerstone Vagrant
=============

Cookbook for deploying Cornerstone based ZF2 applications to vagrant VMs. This cookbook layers a Cornerstone application and several helpful
developer tools on top of the php-webserver cookbook.

Cookbooks
---------

* [web-developer-cookbook](https://github.com/turbine-web/web-developer-cookbook)
* [php-webserver](https://github.com/turbine-web/php-webserver)
* [platform_packages](https://github.com/fnichol/chef-platform_packages)

Attributes
----------

* `node['cornerstone-vagrant']['project']` - The project name ex. 'cornerstone'
* `node['cornerstone-vagrant']['environment']` - Application environment, ex. 'vagrant'
* `node['cornerstone-vagrant']['siteslug']` - The hostname that comes before '.com' usually the same as the `project`
* `node['cornerstone-vagrant']['www-user-group-name']` - The apache user group name
* `node['cornerstone-vagrant']['known-host']` - A host that should be added to the known_hosts file before composer is run

Recipes
-------

## cornerstone-vagrant:default

The default recipe should be used to setup a Cornerstone based ZF2 application on a vagrant virtual machine. First it creates a
php webserver virtual machine via the [php-webserver](https://github.com/turbine-web/php-webserver) cookbook and then it
adds a variety of helpful tools to the server.

The first set of tools is installed by the [web-developer-cookbook](https://github.com/turbine-web/web-developer-cookbook)
which installs the following by default:

* `git`
* `nodejs`
* `grunt`
* `ruby`
* `casperjs`

The second set of tools is installed by the [platform_packages](https://github.com/fnichol/chef-platform_packages) cookbook.
which installs the following tools by default:

* `vim`
* `dos2unix`
* `wireshark`
* `tshark`

Finally the recipe assumes the application code is available at /vagrant it will `cd` there and execute the following tasks:

* Add a configurable git server to the ssh known hosts (optional)
* `composer install` - downloads application's dependencies
* `application initialize` - generates the vhost
* `a2ensite` - enables the vhost
* `apache2 restart` - restarts apache.

Usage
-----

This cookbook will composer install, initialize the application, create the vhost, enable the site, and restart apache.
To use it simply add `cornerstone-vagrant` to your vagrant file's run list and your Berksfile.

License
------------------

Copyright:: 2014 web-masons Contributors

Licensed under the Apache License, Version 2.0 (the 'License');
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an 'AS IS' BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request