# Update composer dependencies
node['deploy'].each do |appname, deploy|
    update_composer do
        path "#{deploy['deploy_to']}/#{deploy['composer']['dir']}"
        self_update deploy['composer']['self_update']
        as_update deploy['composer']['as_update']
    end
end