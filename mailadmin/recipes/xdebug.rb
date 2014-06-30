# Install and configure xdebug

%w{php-devel php-pear gcc gcc-c++ autoconf automake}.each do |name|
	package name do
		action :install
	end
end

# Enable xdebug for unit test code coverage
# sudo sed -i "s/;xdebug;.*;xdebug;//g" /etc/php.ini
# sudo bash -c 'echo ";xdebug;" >> /etc/php.ini'
# sudo bash -c 'echo "[xdebug]" >> /etc/php.ini'
# sudo bash -c 'echo "zend_extension=\"/usr/lib64/php/modules/xdebug.so\"" >> /etc/php.ini'
# sudo bash -c 'echo "xdebug.remote_enable = 1" >> /etc/php.ini'
# sudo bash -c 'echo ";xdebug;" >> /etc/php.ini'