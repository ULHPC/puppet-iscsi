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

$names = ["ensure", "protocol", "port", "packagename"]

notice("iscsi::params::ensure = ${iscsi::params::ensure}")
notice("iscsi::params::protocol = ${iscsi::params::protocol}")
notice("iscsi::params::port = ${iscsi::params::port}")
notice("iscsi::params::packagename = ${iscsi::params::packagename}")

#each($names) |$v| {
#    $var = "iscsi::params::${v}"
#    notice("${var} = ", inline_template('<%= scope.lookupvar(@var) %>'))
#}
