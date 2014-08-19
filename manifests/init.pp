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
  $ldap        = false,
  $ldapauth    = false,
  $ldaptls     = false,
  $ldapserver  = undef,
  $ldapbasedn  = undef,
  $nis         = false,
  $nisdomain   = undef,
  $nisserver   = undef,
  $passalgo    = 'md5',
  $shadow      = true,
  $krb5        = false,
  $krb5realm   = undef,
  $krb5kdc     = undef,
  $krb5kadmin  = undef,
  $cache       = false,
  $fingerprint = false,
  $winbind     = false,
  $winbindauth = false,
  $smbsecurity = 'ads',
  $smbrealm    = undef,
  $smbservers  = undef,
  $winbindjoin = undef,
) inherits authconfig::params {

  case $::osfamily {

    'RedHat' : {
      # LDAP
      if $ldap {

        if $ldapserver == undef {
          fail('The ldapserver parameter is required when ldap set to true')
        }

        if $ldapbasedn == undef {
          fail('The ldapbasedn parameter is required when ldap is set to true')
        }

      }

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
        $ldapbasedn_val = "--ldapbasedn='${ldapbasedn}'"
      }

      if $ldapserver {
        $ldapserver_val = "--ldapserver=${ldapserver}"
      }

      # NIS
      if $nis {

        if $nisdomain == undef {
          fail('The nisdomain parameter is required when nis set to true')
        }

        if $nisserver == undef {
          fail('The nisserver parameter is required when nis is set to true')
        }

      }

      $nis_flg = $nis ? {
        true    => '--enablenis',
        default => '--disablenis',
      }

      if $nisdomain {
        $nisdomain_val = "--nisdomain=${nisdomain}"
      }

      if $nisserver {
        $nisserver_val = "--nisserver=${nisserver}"
      }

      # MD5
      $md5_flg = $passalgo ? {
        md5     => '--enablemd5',
        default => '--disablemd5',
      }

      # hash/crypt algorithm for new passwords
      if ($passalgo) {
        $passalgo_val = "--passalgo=${passalgo}"
      }

      # SHADOW
      $shadow_flg = $shadow ? {
        true    => '--enableshadow',
        default => '--disableshadow',
      }

      # Kerberos
      if $krb5 {

        if $krb5realm == undef {
          fail('The krb5realm parameter is required when krb5 set to true')
        }

        if $krb5kdc == undef {
          fail('The krb5kdc parameter is required when krb5 is set to true')
        }

        if $krb5kadmin == undef {
          fail('The krb5kadmin parameter is required when krb5 is set to true')
        }

      }

      $krb_flg = $krb5 ? {
        true    => '--enablekrb5',
        default => '--disablekrb5',
      }

      if ($krb5realm) {
        $krb5realm_val = "--krb5realm=${krb5realm}"
      }

      if (is_array($krb5kdc)) {
        $kdc_joined = join($krb5kdc, ',')
        $krb_kdc    = "--krb5kdc=${kdc_joined}"
      }
      else {
        $krb_kdc = "--krb5kdc=${krb5kdc}"
      }

      if ($krb5kadmin) {
        $krb5kadmin_val = "--krb5adminserver=${krb5kadmin}"
      }

      # Winbind
      if ($winbind) {
        #smbrealm= Active directory domain (e.g. yourcompany.com)
        if $smbrealm == undef {
          fail('The smbrealm parameter is required when winbind is set to true')
        }

        #winbindjoin= User name of domain admin user to authenticate the domain join of the machine.
        if $winbindjoin == undef {
          fail('The winbindjoin parameter is required when winbind is set to true')
        }

        if $smbservers == undef {
          fail('The smbservers parameter is required when winbind is set to true')
        }
      }

      $winbind_flg = $winbind ? {
        true    => '--enablewinbind',
        default => '--disablewinbind',
      }

      $winbindauth_flg = $winbindauth ? {
        true    => '--enablewinbindauth',
        default => '--disablewinbindauth',
      }

      if ($smbsecurity) {
        $smbsecurity_val = "--smbsecurity=${smbsecurity}"
      }

      if ($smbrealm) {
        $smbrealm_val = "--smbrealm=${smbrealm}"
      }

      if ($winbindjoin) {
        $winbindjoin_val = "--winbindjoin=${winbindjoin}"
      }

      if (is_array($smbservers)) {
        $smbservers_joined = join($smbservers, ',')
        $smbservers_val = "--smbservers=${smbservers_joined}"
      }


      # Cache/nscd
      $cache_flg = $cache ? {
        true    => '--enablecache',
        default => '--disablecache',
      }

      $fingerprint_flg = $fingerprint ? {
        true    => '--enablefingerprint',
        default => '--disablefingerprint',
      }

      # construct the command
      $ldap_flags = $ldap ? {
        true    => "${ldap_flg} ${ldapauth_flg} ${ldaptls_flg} ${ldapbasedn_val} ${ldapserver_val}",
        default => '',
      }

      $nis_flags = $nis ? {
        true    => "${nis_flg} ${nisdomain_val} ${nisserver_val}",
        default => '',
      }

      $krb5_flags = $krb5 ? {
        true    => "${krb_flg} ${krb5realm_val} ${krb_kdc} ${$krb5kadmin_val}",
        default => '',
      }

      $winbind_flags = $winbind ? {
        true    => "${winbind_flg} ${winbindauth_flg} ${smbsecurity_val} ${smbrealm_val} ${winbindjoin_val} ${smbservers_val}",
        default => '',
      }

      $pass_flags            = "${md5_flg} ${passalgo_val} ${shadow_flg}"
      $authconfig_flags      = "${ldap_flags} ${nis_flags} ${pass_flags} ${krb5_flags} ${winbind_flags} ${cache_flg}"
      $authconfig_update_cmd = "authconfig ${authconfig_flags} --update"
      $authconfig_test_cmd   = "authconfig ${authconfig_flags} --test"
      $exec_check_cmd        = "/usr/bin/test \"`${authconfig_test_cmd}`\" = \"`authconfig --test`\""

      if ($cache) {
        package { $authconfig::params::cache_packages:
          ensure => installed,
        } ->
        service { $authconfig::params::cache_services:
          ensure     => running,
          enable     => true,
          hasstatus  => true,
          hasrestart => true,
        }
      }

      if ($krb5) {
        package { $authconfig::params::krb5_packages:
          ensure => installed,
        }
      }

      if ($ldap) {
        package { $authconfig::params::ldap_packages:
          ensure => installed,
        } ->
        service { $authconfig::params::ldap_services:
          ensure     => running,
          enable     => true,
          hasstatus  => true,
          hasrestart => true,
        }
      }

      package { $authconfig::params::packages:
        ensure => installed,
      } ->
      service { $authconfig::params::services:
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
      } ->
      exec {'authconfig command':
        path    => '/usr/sbin',
        command => $authconfig_update_cmd,
        unless  => $exec_check_cmd
      }
    }
    default : {
      fail("${::osfamily} is not supported")
    }
  }

}
