# == Class: authconfig
#
# Full description of class authconfig here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { authconfig:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class authconfig (
  $ldap = false,
  $ldapauth = false,
  $ldaptls = false,
  $ldapserver = undef,
  $ldapbasedn = undef,
  ){

  case $::osfamily {

    'RedHat' : {
      # LDAP
      $ldap_flg = $ldap ? {
        true    => '--enableldap',
        default => '--disableldap',
      }
      $ldapauth_flg = $ldapauth ? {
        true    => '--enableldapauth',
        default => '--disableldapauth',
      }
      $ldaptls_flg = $ldaptls ? {
        true    => '--enableldaptls',
        default => '--disableldaptls',
      }
      if $ldapbasedn {
        $ldapbasedn_val = "--ldapbasedn=${ldapbasedn} "
      }
      if $ldapserver {
        $ldapserver_val = "--ldapserer=${ldapserver} "
      }

      $authconfig_cmd = "authconfig ${ldap_flg} ${ldapauth_flg} ${ldaptls_flg} ${ldapbasedn_val} ${ldapserver_val} --update"

      package {'authconfig' :
        ensure => installed,
      } ->
      exec {'authconfig command' :
        path    => '/usr/sbin',
        command => $authconfig_cmd,
      }
    }
    default : {
      fail("${::osfamily} is not supported")
    }
  }

}
