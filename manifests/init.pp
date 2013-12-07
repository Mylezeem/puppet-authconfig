# == Class: authconfig
#
# A puppet module that enables authconfig configuration simply
#
# === Parameters
#
# === Authors
#
# Yanis Guenane <yguenane@gmail.com>
#
# === Copyright
#
# Copyright 2013 Yanis Guenane, unless otherwise noted.
#
class authconfig (
  $ldap       = false,
  $ldapauth   = false,
  $ldaptls    = false,
  $ldapserver = undef,
  $ldapbasedn = undef,
  $nis        = false,
  $nisdomain  = undef,
  $nisserver  = undef,
  $md5        = false,
  $shadow     = true,
  ){

  include authconfig::params

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
        $ldapserver_val = "--ldapserver=${ldapserver} "
      }

      # NIS
      $nis_flg = $nis ? {
        true    => '--enablenis',
        default => '--disablenis',
      }
      if $nisdomain {
        $nisdomain_val = "--nisdomain=${nisdomain} "
      }
      if $nisserver {
        $nisserver_val = "--nisserver=${nisserver} "
      }

      # MD5
      $md5_flg = $md5 ? {
        true    => '--enablemd5',
        default => '--disablemd5',
      }

      # SHADOW
      $shadow_flg = $shadow ? {
        true    => '--enableshadow',
        default => '--disableshadow',
      }

      $authconfig_cmd = "authconfig ${ldap_flg} ${ldapauth_flg} ${ldaptls_flg} ${ldapbasedn_val} ${ldapserver_val} ${nis_flg} ${nisdomain} ${nisserver} ${md5_flg} ${shadow_flg} --update"

      package {$authconfig::params::packages :
        ensure => installed,
      } ->
      service {$autconfig::params::services :
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
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
