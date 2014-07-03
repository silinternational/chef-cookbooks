name "silphp"
description "Custom PHP related recipes"
license "MIT"
version "0.0.1"
maintainer "SIL International, GTIS"

recipe "silphp::configure", "Configure script to create php arrays out of provided JSON"
recipe "silphp::xdebug", "Install and enable xdebug in PHP, primarily used in dev environments"
recipe "silphp::composer", "Install composer.phar if needed, run self-update on composer, and install composer dependencies for each deploy application"
recipe "silphp::yii_migrate", "Execute yiic migrate --interactive=0 for each deploy application"

depends "php"