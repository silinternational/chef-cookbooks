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

# Create vhost for mail-admin.local
web_app "mailadmin" do
	server_name node['vhost']['server_name']
	server_aliases node['vhost']['server_aliases']
	docroot node['vhost']['docroot']
	allow_override node['vhost']['allow_override']
	server_port node['vhost']['port']
	cookbook "apache2"
end

include_recipe "database::mysql"

# Create mailadmin database
mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}
mysql_database 'mailadmin' do
  connection mysql_connection_info
  action :create
end
mysql_database 'mailadmin_test' do
  connection mysql_connection_info
  action :create
end

# Create maildmin database users
mysql_database_user 'mailadmin' do
	username 'mailadmin'
	password 'mailadmin'
	database_name 'mailadmin'
	privileges [:all]
	connection mysql_connection_info
	action [:create,:grant]
end
mysql_database_user 'mailadmin_test' do
	username 'mailadmin_test'
	password 'mailadmin_test'
	database_name 'mailadmin_test'
	privileges [:all]
	connection mysql_connection_info
	action [:create,:grant]
end

# Disable EnableSendFile in apache, needed when using vagrant on windows
file "/etc/httpd/conf.d/sendfile.conf" do
	owner "root"
	group "root"
	mode "0644"
	content "EnableSendfile off"
	action :create
	notifies :restart, "service[apache2]", :immediately
end
