# File::      <tt>debian.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: iscsi::target::debian
#
# Specialization class for Debian systems
class iscsi::target::debian inherits iscsi::target::common {


    file { $iscsi::params::debian_init:
        ensure => $iscsi::target::ensure,
        owner  => $iscsi::params::configfile_owner,
        group  => $iscsi::params::configfile_group,
        mode   => $iscsi::params::debian_init_mode,
        source => 'puppet:///modules/iscsi/tgt_init_debian',
    }

    File[$iscsi::params::debian_init] -> Service['tgtd']

}
