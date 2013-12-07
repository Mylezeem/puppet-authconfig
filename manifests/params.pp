class authconfig::params () {

    $packages = ['authconfig', 'openldap-clients', 'nss-pam-ldapd', 'pam_ldap']

    $services = ['nscd', 'nslcd']

}

