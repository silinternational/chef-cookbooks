# Recipe installs and configures dependencies for Mail Admin

# Required packages
packages = ["git", "httpd", "php", "php-mcrypt", 
			"php-mysql", "php-pdo", "php-xml", 
			"php-mbstring", "php-ldap"]

packages.each do |name|
	package name do
		action :install
	end
end

include_recipe "apache2"

web_app "mailadmin" do
	server_name node['vhost']['hostname']
	docroot node['vhost']['docroot']
	allow_override node['vhost']['allow_override']
	server_port node['vhost']['port']
	cookbook "apache2"
end