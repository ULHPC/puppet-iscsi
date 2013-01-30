# File::      <tt>iscsi-target.pp</tt>
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
            fail("Module $module_name is not supported on $operatingsystem")
        }
    }
}

# ------------------------------------------------------------------------------
# = Class: iscsi::common
#
# Base class to be inherited by the other iscsi classes
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class iscsi::target::common {

    # Load the variables used in this module. Check the iscsi-params.pp file
    require iscsi::params

    package { $iscsi::params::packagename :
        ensure => "${iscsi::target::ensure}",
        before => Service['tgtd']
    }
    service { 'tgtd':
        name       => "${iscsi::params::servicename}",
        enable     => true,
        ensure     => running,
        subscribe  => File['targets.conf'],
    }

    file { 'targets.conf':
        path    => "${iscsi::params::configfile}",
        owner   => "${iscsi::params::configfile_owner}",
        group   => "${iscsi::params::configfile_group}",
        mode    => "${iscsi::params::configfile_mode}",
        ensure  => "${iscsi::target::ensure}",
        notify  => Service['tgtd'],
    }

    if ($iscsi::target::content != '')
    {
        File['targets.conf'] {
            content => "${iscsi::target::content}"
        }
    }
    elsif ($iscsi::target::source != '')
    {
        File['targets.conf'] {
            source => "${iscsi::target::source}"
        }
    }

}


# ------------------------------------------------------------------------------
# = Class: iscsi::target::debian
#
# Specialization class for Debian systems
class iscsi::target::debian inherits iscsi::target::common {


    file { "${iscsi::params::debian_init}":
        owner   => "${iscsi::params::configfile_owner}",
        group   => "${iscsi::params::configfile_group}",
        mode    => "${iscsi::params::debian_init_mode}",
        ensure  => "${iscsi::target::ensure}",
        source  => "puppet:///modules/iscsi/tgt_init_debian",
    }

    File["${iscsi::params::debian_init}"] -> Service["tgtd"]

}

# ------------------------------------------------------------------------------
# = Class: iscsi::ubuntu
#
# Specialization class for Debian systems
class iscsi::target::ubuntu inherits iscsi::target::common { }

# ------------------------------------------------------------------------------
# = Class: iscsi::redhat
#
# Specialization class for Redhat systems
class iscsi::target::redhat inherits iscsi::target::common { }


