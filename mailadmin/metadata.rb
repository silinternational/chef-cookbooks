name "mailadmin"
description "Provides recipes for configuring Mail Admin"
license "MIT"
version "0.0.1"
maintainer "SIL GTIS"

recipe "mailadmin", "Main application configuration and core dependencies"

depends "apache2"
depends "mysql-chef_gem"
depends "database"
depends "application"