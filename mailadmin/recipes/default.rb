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
