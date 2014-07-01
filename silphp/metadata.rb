name "silphp"
description "Custom PHP recipes, extending aws/opsworks-cookbooks"
license "MIT"
version "0.0.1"
maintainer "SIL GTIS"

recipe "silphp::configure", "Configure script to create php arrays out of provided JSON"
recipe "silphp::xdebug", "Install and enable xdebug in PHP, primarily used in dev environments"

depends "php"