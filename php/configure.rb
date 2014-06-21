node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping deploy::php application #{application} as it is not an PHP app")
    next
  end

  # write out params.php
  template "#{deploy[:deploy_to]}/protected/config/params.php" do
    cookbook 'php'
    source 'array.php.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(
      :data => deploy[:params],
    )
    only_if do
      File.exists?("#{deploy[:deploy_to]}/protected/config")
    end
  end

  # write out local.php
  template "#{deploy[:deploy_to]}/protected/config/local.php" do
    cookbook 'php'
    source 'array.php.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(
      :data => deploy[:local],
    )
    only_if do
      File.exists?("#{deploy[:deploy_to]}/protected/config")
    end
  end
end