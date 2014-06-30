# Install and configure xdebug

%w{php-devel php-pear gcc gcc-c++ autoconf automake}.each do |name|
	package name do
		action :install
	end
end

# Use pecl to install xdebug
sudo pecl install Xdebug

# Enable xdebug for unit test code coverage
if grep -q ";xdebug;" /etc/php.ini; then
    echo 'xdebug already setup in php.ini'
else
    echo 'Adding the following to /etc/php.ini'
    cat <<EOL | sudo tee -a /etc/php.ini
;xdebug;
[xdebug]
zend_extension="/usr/lib64/php/modules/xdebug.so"
xdebug.remote_enable = 1
EOL
fi