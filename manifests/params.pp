# authconfig::params
class authconfig::params () {

  $packages = ['authconfig']
  $cache_packages = ['nscd']
  $ldap_packages  = ['openldap-clients', 'nss-pam-ldapd', 'pam_ldap']
  $krb5_packages  = ['pam_krb5', 'krb5-workstation']
  $nis_packages   = ['ypbind']
  $nis_services   = ['ypbind']
  $services       = []
  $cache_services = ['nscd']
  $ldap_services  = ['nslcd']

}
