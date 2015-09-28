# File::      <tt>iscsi-params.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: iscsi::params
#
# In this class are defined as variables values that are used in other
# iscsi classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# The usage of a dedicated param classe is advised to better deal with
# parametrized classes, see
# http://docs.puppetlabs.com/guides/parameterized_classes.html
#
# [Remember: No empty lines between comments and class definition]
#
class iscsi::params {

    ######## DEFAULTS FOR VARIABLES USERS CAN SET ##########################
    # (Here are set the defaults, provide your custom variables externally)
    # (The default used is in the line with '')
    ###########################################

    # ensure the presence (or absence) of iscsi
    $ensure = $iscsi_ensure ? {
        ''      => 'present',
        default => "${iscsi_ensure}"
    }

    # The Protocol used. Used by monitor and firewall class. Default is 'tcp'
    $protocol = $iscsi_protocol ? {
        ''      => 'tcp',
        default => "${iscsi_protocol}",
    }
    # The port number. Used by monitor and firewall class. The default is 22.
    $port = $iscsi_port ? {
        ''      => 3260,
        default => "${iscsi_port}",
    }


    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    # iscsi packages
    $packagename = $::operatingsystem ? {
        default => ['open-iscsi', 'tgt'],
    }

    $servicename = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => 'tgt',
        default                 => 'tgtd'
    }

    $configfile = $::operatingsystem ? {
        default => '/etc/tgt/targets.conf',
    }
    $configfile_init = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => '/etc/default/tgt',
        default                 => '/etc/sysconfig/tgtd'
    }

    $debian_init      = '/etc/init.d/tgt'
    $debian_init_mode = '755'

    $configfile_mode = $::operatingsystem ? {
        default => '0644',
    }
    $configfile_owner = $::operatingsystem ? {
        default => 'root',
    }
    $configfile_group = $::operatingsystem ? {
        default => 'root',
    }


}

