# Recipe installs and configures dependencies for Addressbook

# Required packages
packages = ["git", "httpd", "php", "php-mcrypt", "php-xml", "php-mbstring", "php-pdo"]

packages.each do |name|
    package name do
        action :install
    end
end

# Put SSL cert files where they go
file "#{node['vhost']['ssl_cert_path']}/#{node['vhost']['server_name']}.crt" do
    owner "root"
    group "root"
    mode "0644"
    action :create
    content node['vhost']['ssl_cert_content']
end
file "#{node['vhost']['ssl_key_path']}/#{node['vhost']['server_name']}.key" do
    owner "root"
    group "root"
    mode "0600"
    action :create
    content node['vhost']['ssl_key_content']
end

# Create vhost for addressbook
web_app "addressbook" do
    cookbook "silapache2"
    server_name node['vhost']['server_name']
    server_aliases node['vhost']['server_aliases']
    docroot node['vhost']['docroot']
    allow_override node['vhost']['allow_override']
    server_port node['vhost']['port']
    ssl_enable node['vhost']['ssl_enable']
    ssl_cert_file "#{node['vhost']['ssl_cert_path']}/#{node['vhost']['server_name']}.crt"
    ssl_key_file "#{node['vhost']['ssl_key_path']}/#{node['vhost']['server_name']}.key"
end

# Configure apps
node['deploy'].each do |appname, deploy|

    # Update folder permissions
    directory "#{deploy['deploy_to']}/protected/runtime" do
        owner "apache"
        group "apache"
        mode "0775"
    end
    directory "#{deploy['deploy_to']}/public/assets" do
        owner "apache"
        group "apache"
        mode "0775"
    end

    # Create simplesaml symlink if needed
    link "#{deploy['deploy_to']}/public/simplesaml" do
        to "#{deploy['deploy_to']}/simplesamlphp/www/"
    end

end
