name 'cornerstone-vagrant'
maintainer 'Colin Hubert'
maintainer_email 'chubert@turbine.com'
license 'Apache 2'
description 'Installs/Configures a cornerstone based application in a vagrant environment'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

depends 'php-webserver'
depends 'platform_packages'
depends 'web-developer-cookbook'