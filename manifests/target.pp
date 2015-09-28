# File::      <tt>target.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: iscsi::target
#
# Configure and manage iscsi target server
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of iscsi target tools
# $source:: *Default*: empty. Source for the targets.conf configuration file
# $content:: *Default*: empty. Content for the targets.conf configuration file
#
# == Actions:
#
# Install and configure iscsi targets
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     import iscsi
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'iscsi::target':
#             ensure  => 'present',
#             content => template("iscsi/viridis-targets.conf.erb")
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class iscsi::target(
    $ensure  = $iscsi::params::ensure,
    $source  = '',
    $content = ''
)
inherits iscsi::params
{
    info ("Configuring iscsi::target (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("iscsi 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian:                 { include iscsi::target::debian }
        ubuntu:                 { include iscsi::target::ubuntu }
        redhat, fedora, centos: { include iscsi::target::redhat }
        default: {
            fail("Module ${module_name} is not supported on ${::operatingsystem}")
        }
    }
}
