# File::      <tt>common.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
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
        ensure => $iscsi::target::ensure,
        before => Service['tgtd']
    }
    service { 'tgtd':
        ensure    => running,
        name      => $iscsi::params::servicename,
        enable    => true,
        subscribe => File['targets.conf'],
    }

    file { 'targets.conf':
        ensure  => $iscsi::target::ensure,
        path    => $iscsi::params::configfile,
        owner   => $iscsi::params::configfile_owner,
        group   => $iscsi::params::configfile_group,
        mode    => $iscsi::params::configfile_mode,
        notify  => Service['tgtd'],
        require => Package[$iscsi::params::packagename]
    }

    if ($iscsi::target::content != '')
    {
        File['targets.conf'] {
            content => $iscsi::target::content
        }
    }
    elsif ($iscsi::target::source != '')
    {
        File['targets.conf'] {
            source => $iscsi::target::source
        }
    }

}
