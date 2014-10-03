name "silapache2"
description "Custom apache2 related recipes and templates"
license "MIT"
version "0.0.2"
maintainer "SIL International, GTIS"

recipe "silapache2::default", "Empty default recipe"
recipe "silapache2::deploy_vhosts", "Create SSL cert files and vhost entries from entries in node['deploy']"

depends "apache2"