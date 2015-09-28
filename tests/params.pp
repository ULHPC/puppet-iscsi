# File::      <tt>params.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2015 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# You need the 'future' parser to be able to execute this manifest (that's
# required for the each loop below).
#
# Thus execute this manifest in your vagrant box as follows:
#
#      sudo puppet apply -t --parser future /vagrant/tests/params.pp
#
#

include 'iscsi::params'

$names = ["ensure", "protocol", "port", "packagename", "servicename", "configfile", "configfile_init", "debian_init", "debian_init_mode", "configfile_mode", "configfile_owner", "configfile_group"]

notice("iscsi::params::ensure = ${iscsi::params::ensure}")
notice("iscsi::params::protocol = ${iscsi::params::protocol}")
notice("iscsi::params::port = ${iscsi::params::port}")
notice("iscsi::params::packagename = ${iscsi::params::packagename}")
notice("iscsi::params::servicename = ${iscsi::params::servicename}")
notice("iscsi::params::configfile = ${iscsi::params::configfile}")
notice("iscsi::params::configfile_init = ${iscsi::params::configfile_init}")
notice("iscsi::params::debian_init = ${iscsi::params::debian_init}")
notice("iscsi::params::debian_init_mode = ${iscsi::params::debian_init_mode}")
notice("iscsi::params::configfile_mode = ${iscsi::params::configfile_mode}")
notice("iscsi::params::configfile_owner = ${iscsi::params::configfile_owner}")
notice("iscsi::params::configfile_group = ${iscsi::params::configfile_group}")

#each($names) |$v| {
#    $var = "iscsi::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
