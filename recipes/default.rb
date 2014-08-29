include_recipe 'php-webserver'
include_recipe 'web-developer-cookbook'
include_recipe 'platform_packages'

# setup known hosts command
known_hosts_cmd = ''
if node['cornerstone-vagrant']['known_host'] != ''
  # rubocop:disable LineLength
  known_hosts_cmd = 'ssh-keyscan -H ' + node['cornerstone-vagrant']['known_host'] + ' >> ~/.ssh/known_hosts;'
  # rubocop:enable LineLength
end

# download dependencies
execute "#{node['cornerstone-vagrant']['project']}-composer-install" do
  # need to run composer as a non-root user
  # rubocop:disable LineLength
  command "su -c '" + known_hosts_cmd + "cd /vagrant;COMPOSER_PROCESS_TIMEOUT=#{node['cornerstone-vagrant']['composer-timeout']} composer install;' vagrant"
  # rubocop:enable LineLength
  action :run
  notifies :run, "execute[#{node['cornerstone-vagrant']['project']}-initialize]"
end

# initialize the project and generate the vhost config
execute "#{node['cornerstone-vagrant']['project']}-initialize" do
  # rubocop:disable LineLength
  command "php /vagrant/cornerstone.php application initialize --env=#{node['cornerstone-vagrant']['environment']}"
  # rubocop:enable LineLength
  action :run
  notifies :run, "execute[#{node['cornerstone-vagrant']['project']}-vhost]"
end

# add vagrant's vendor/bin to the path variable
#  If you compose in phpunit it will be available in your path etc...
execute "#{node['cornerstone-vagrant']['project']}-dev-path-setup" do
  command 'echo export PATH=/vagrant/vendor/bin:$PATH >> /etc/profile'
  action :run
end

# Enable the vhost and restart apache
execute "#{node['cornerstone-vagrant']['project']}-vhost" do
  command "a2ensite #{node['cornerstone-vagrant']['siteslug']}.com.vhost"
  action :nothing # this should only be triggered after composer-install
  notifies :restart, 'service[apache2]', :immediately
end
