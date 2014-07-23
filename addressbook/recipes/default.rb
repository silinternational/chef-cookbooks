# Recipe installs and configures dependencies for Addressbook

# Required packages
packages = ["git", "httpd", "php", "php-mcrypt", "php-xml", "php-mbstring", "php-pdo"]

packages.each do |name|
    package name do
        action :install
    end
end

# Put SSL cert files where they go
file "#{node['vhost']['ssl']['cert_path']}/#{node['vhost']['server_name']}.crt" do
    owner "root"
    group "root"
    mode "0644"
    action :create
    content node['vhost']['ssl']['cert_content']
    only_if { node['vhost']['ssl'] && node['vhost']['ssl']['enabled'] && !File.exists?("#{node['vhost']['ssl']['cert_path']}/#{node['vhost']['server_name']}.crt") }
end
file "#{node['vhost']['ssl']['key_path']}/#{node['vhost']['server_name']}.key" do
    owner "root"
    group "root"
    mode "0600"
    action :create
    content node['vhost']['ssl']['key_content']
    only_if { node['vhost']['ssl'] && node['vhost']['ssl']['enabled'] && !File.exists?("#{node['vhost']['ssl']['key_path']}/#{node['vhost']['server_name']}.key") }
end
file "#{node['vhost']['ssl']['intermediate_cert_file']}" do
    owner "root"
    group "root"
    mode "0644"
    action :create
    content node['vhost']['ssl']['intermediate_cert_content']
    only_if { node['vhost']['ssl'] && node['vhost']['ssl']['enabled'] && node['vhost']['ssl']['intermediate_cert_file'] && !File.exists?(node['vhost']['ssl']['intermediate_cert_file']) }
end

# Create vhost for addressbook
web_app "addressbook" do
    cookbook "silapache2"
    server_name node['vhost']['server_name']
    server_aliases node['vhost']['server_aliases']
    docroot node['vhost']['docroot']
    allow_override node['vhost']['allow_override']
    server_port node['vhost']['port']
    ssl_config node['vhost']['ssl']
end

# Configure apps
node['deploy'].each do |appname, deploy|

    # Update folder permissions
    directory "#{deploy['deploy_to']}#{deploy['aws_extra_path']}/protected/runtime" do
        owner "apache"
        group "apache"
        mode "0775"
    end
    directory "#{deploy['deploy_to']}#{deploy['aws_extra_path']}/public/assets" do
        owner "apache"
        group "apache"
        mode "0775"
    end

    # Create simplesaml symlink if needed
    link "#{deploy['deploy_to']}#{deploy['aws_extra_path']}/public/simplesaml" do
        to "#{deploy['deploy_to']}#{deploy['aws_extra_path']}/simplesamlphp/www/"
    end

end
