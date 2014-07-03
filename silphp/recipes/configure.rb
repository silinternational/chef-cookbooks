node['deploy'].each do |application, deploy|
  
  # write out local.php
  template 'local.php' do
    source 'array.php.erb'
    path "#{deploy['deploy_to']}/#{deploy['config_path']}/local.php"
    mode '0664'
    owner deploy['user']
    group deploy['group']
    variables(
      :data => Silphp::Helper.hash_to_array(deploy['local']),
    )
    #only_if defined? deploy['local']
  end

  # write out params.php
  template 'params.php' do
    source 'array.php.erb'
    path "#{deploy['deploy_to']}/#{deploy['config_path']}/params.php"
    mode '0664'
    owner deploy['user']
    group deploy['group']
    variables(
      :data => Silphp::Helper.hash_to_array(deploy['params']),
    )
    #only_if defined? deploy['params']
  end

end