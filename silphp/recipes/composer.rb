# Update composer dependencies
node['deploy'].each do |appname, deploy|
    if ( deploy['composer'] && deploy['composer'].is_a?(::Hash) )
        update_composer do
            path "#{deploy['deploy_to']}/#{deploy['composer']['dir']}"
            self_update deploy['composer']['self_update']
            as_update deploy['composer']['as_update']
        end
    end
end