# == Class: authconfig
#
# A puppet module that enables authconfig configuration simply
#
# === Parameters
#
#  [*ldap*]
#    Whether to enable LDAP for user information.
#
#  [*ldapauth*]
#    Whether to enable LDAP for user authentication.
#
#  [*ldaptls*]
#    Whether to enable use of TLS with LDAP.
#
#  [*ldapserver*]
#    LDAP server address to connect to.
#
#  [*ldapbasedn*]
#    LDAP base dn to connet to.
#
#  [*ldaploadcacert*]
#    Loads a CA certificate over HTTP.
#
#  [*nis*]
#    Whether to enable NIS for user information.
#
#  [*nisdomain*]
#    NIS Domain
#
#  [*nisserver*]
#    NIS Server
#
#  [*shadow*]
#    Enable shadow password
#
#  [*fingerprint*]
#    Enable fingerprint authentication
#
#  [*passalgo*]
#    Password hashing algorithm
#
#  [*sssd*]
#    Whether to enable SSSD - caches credentials from a remote provider such as LDAP.
#
#  [*sssdauth*]
#    Whether to enable SSSD Auth - Allows users to authenticate from a local cache pulled from a remote provider such as LDAP.
#
#  [*forcelegacy*]
#    Pass true or false, which equate to yes or no - undef will not set the value.  Used in conjunction with SSSD and other caching services.
#
#  [*pamaccess*]
#    Whether to enable pam access - Allows administrators to configure the authentication process to run the pam_access module during account authorization.
#
#  [*locauthorize*]
#    Whether to bypass checking network authentication services for authorization
#
#  [*sysnetauth*]
#    Whether to allow authentication of system accounts
#
#  [*krb5*]
#    Whether to enable Kerberos.
#
#  [*krb5realm*]
#    Specify Kerberos realm.
#
#  [*krb5kdc*]
#    Specify Kerberos KDC
#
#  [*krb5kadmin*]
#    Specify Kerberos administration server
#
#  [*krb5kdcdns*]
#    Enable use of DNS to find kerberos KDCs
#
#  [*krb5realmdns*]
#    Enable use of DNS to find kerberos realms
#
#  [*preferdns*]
#    Prefer dns over wins or nis for hostname resolution
#
#  [*winbind*]
#    Whether to enable Winbind
#
#  [*winbindauth*]
#    Whether to enable Winbind for user authentication
#
#  [*smbsecurity*]
#    The style of Winbind connection. Default: `ads`
#
#  [*smbrealm*]
#    Specify Active Directory realm
#
#  [*smbworkgroup*]
#    Specify Active Directory workgroup
#
#  [*smbservers*]
#   Specify Active Directory server or servers. Pass a string or an array.
#
#  [*winbindjoin*]
#    Specify user credentials of a domain administrator in the form `username@domain%password`
#
#  [*cache*]
#    Whether to use naming services caches
#
#  [*mkhomedir*]
#
#Whether to automatically create user home dir on first login
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
  $ldap           = false,
  $ldapauth       = false,
  $ldaptls        = false,
  $ldapserver     = undef,
  $ldapbasedn     = undef,
  $ldaploadcacert = undef,
  $sssd           = false,
  $sssdauth       = false,
  $locauthorize   = false,
  $sysnetauth     = false,
  $forcelegacy    = false,
  $pamaccess      = false,
  $nis            = false,
  $nisdomain      = undef,
  $nisserver      = undef,
  $passalgo       = 'md5',
  $shadow         = true,
  $krb5           = false,
  $krb5realm      = undef,
  $krb5kdc        = undef,
  $krb5kadmin     = undef,
  $cache          = false,
  $fingerprint    = false,
  $winbind        = false,
  $winbindauth    = false,
  $smbsecurity    = 'ads',
  $smbrealm       = undef,
  $smbworkgroup   = undef,
  $smbservers     = undef,
  $winbindjoin    = undef,
  $mkhomedir      = false,
  $krb5kdcdns     = false,
  $krb5realmdns   = false,
  $preferdns      = false,
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

      if $ldaploadcacert {
        $ldaploadcacert_val = "--ldaploadcacert='${ldaploadcacert}'"
      }

      if $ldapserver {
        $ldapserver_val = "--ldapserver=${ldapserver}"
      }

      $sssd_flg = $sssd ? {
        true    => '--enablesssd',
        default => '--disablesssd',
      }

      $sssdauth_flg = $sssdauth ? {
        true    => '--enablesssdauth',
        default => '--disablesssdauth',
      }

      if $::osfamily == 'RedHat' {
        if $::operatingsystemmajrelease >= 6 {
          $forcelegacy_flg = $forcelegacy ? {
            true    => '--enableforcelegacy',
            default => '--disableforcelegacy',
          }
        } else {
          $forcelegacy_flg = ''
        }
      } else {
        $forcelegacy_flg = ''
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
        'md5'     => '--enablemd5',
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

        #smbworkgroup= Active directory workgroup (e.g. MYGROUP)
        if $smbworkgroup == undef {
          fail('The smbworkgroup parameter is required when winbind is set to true')
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

      if ($smbworkgroup) {
        $smbworkgroup_val = "--smbworkgroup=${smbworkgroup}"
      }

      if ($winbindjoin) {
        $winbindjoin_val = "--winbindjoin=${winbindjoin}"
      }

      if (is_array($smbservers)) {
        $smbservers_joined = join($smbservers, ',')
        $smbservers_val = "--smbservers=${smbservers_joined}"
      } else {
        $smbservers_val = "--smbservers=${smbservers}"
      }

      $krb5kdcdns_flg = $krb5kdcdns ? {
        true    => '--enablekrb5kdcdns',
        default => '--disablekrb5kdcdns',
      }

      $krb5realmdns_flg = $krb5realmdns ? {
        true    => '--enablekrb5realmdns',
        default => '--disablekrb5realmdns',
      }

      $preferdns_flg = $preferdns ? {
        true    => '--enablepreferdns',
        default => '--disablepreferdns',
      }

      $locauthorize_flg = $locauthorize ? {
        true    => '--enablelocauthorize',
        default => '--disablelocauthorize',
      }

      $sysnetauth_flg = $sysnetauth ? {
        true    => '--enablesysnetauth',
        default => '--disablesysnetauth',
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

      case $::operatingsystemmajrelease {
        '5':     { $mkhomedir_flg = '' } # not available on EL5
        default: {
          $mkhomedir_flg = $mkhomedir ? {
            true    => '--enablemkhomedir',
            default => '--disablemkhomedir',
          }
        }
      }

      #Add PAM Access
      $pamaccess_flg = $pamaccess ? {
        true    => '--enablepamaccess',
        default => '--disablepamaccess',
      }

      # construct the command
      $ldap_flags = $ldap ? {
        true    => "${ldap_flg} ${ldapauth_flg} ${ldaptls_flg} ${ldapbasedn_val} ${ldaploadcacert_val} ${ldapserver_val}",
        default => '',
      }

      $nis_flags = $nis ? {
        true    => "${nis_flg} ${nisdomain_val} ${nisserver_val}",
        default => '',
      }

      $krb5_flags = $krb5 ? {
        true    => "${krb_flg} ${krb5realm_val} ${krb_kdc} ${krb5kadmin_val} ${krb5kdcdns_flg} ${krb5realmdns_flg}",
        default => '',
      }

      $winbind_flags = $winbind ? {
        true    => "${winbind_flg} ${winbindauth_flg} ${smbsecurity_val} ${smbrealm_val} ${smbworkgroup_val} ${winbindjoin_val} ${smbservers_val}",
        default => '',
      }

      $extra_flags = "${preferdns_flg} ${forcelegacy_flg} ${pamaccess_flg}"

      $pass_flags            = "${md5_flg} ${passalgo_val} ${shadow_flg}"
      $authconfig_flags      = "${ldap_flags} ${nis_flags} ${pass_flags} ${krb5_flags} ${winbind_flags} ${extra_flags} ${cache_flg} ${mkhomedir_flg} ${sssd_flg} ${sssdauth_flg} ${locauthorize_flg} ${sysnetauth_flg}"
      $authconfig_update_cmd = "authconfig ${authconfig_flags} --updateall"
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
          before     => Exec['authconfig command'],
        }
      }

      if ($mkhomedir) {
        package { $authconfig::params::mkhomedir_packages:
          ensure => installed,
        }
      # service oddjobd is started automatically by authconfig
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
        path    => ['/usr/bin', '/usr/sbin'],
        command => $authconfig_update_cmd,
        unless  => $exec_check_cmd,
      }
    }
    default : {
      fail("${::osfamily} is not supported")
    }
  }

}
