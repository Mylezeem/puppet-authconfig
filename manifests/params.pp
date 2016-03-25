# authconfig::params
class authconfig::params () {

  $packages           = ['authconfig']
  $cache_packages     = ['nscd']
  $sssd_packages      = $::operatingsystemmajrelease ? {
    default => ['sssd', 'sssd-client']
  }
  $ldap_packages      = $::operatingsystemmajrelease ? {
    7       => ['openldap-clients', 'nss-pam-ldapd'],
    default => ['openldap-clients', 'nss-pam-ldapd', 'pam_ldap']
  }
  $krb5_packages      = ['pam_krb5', 'krb5-workstation']
  $mkhomedir_packages = $::operatingsystemmajrelease ? {
    5       => ['pam'],
    default => ['oddjob-mkhomedir']
  }
  $nis_packages       = ['ypbind']
  $nis_services       = ['ypbind']
  $services           = []
  $cache_services     = ['nscd']
  $ldap_services      = ['nslcd']
  $sssd_services      = ['sssd']

  $smartcard_packages = [ 'nss-tools', 'nss-pam-ldapd', 'esc', 'pam_pkcs11', 'pam_krb5', 'coolkey', 'pcsc-lite-ccid', 'pcsc-lite', 'pcsc-lite-libs' ]

  $enablerfc2307bis_allowed = (versioncmp("${::operatingsystemmajrelease}.0", '6.0') >= 0)

}
