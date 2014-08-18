#Authconfig

[![Build Status](https://travis-ci.org/Mylezeem/puppet-authconfig.png)](https://travis-ci.org/Mylezeem/puppet-authconfig)

A Puppet module that installs and configure authconfig on EL distribution

**Note**: For this first version it only manages LDAP, NIS, and Kerberos related authentication specifics.  It also handles enable/disable of cacheing (nscd).
          SMB, Winbind, will come in later version. PRs are welcome.

## Usage

### Simple Usage

```puppet
include authconfig
```

This will install the authconfig package if necessary and set `ldap`, `ldapauth` and `ldaptls` to `disable` by default.

### Custom Usage

```puppet
class { 'authconfig' :
  ldap        => true,
  ldapauth    => true,
  ldaptls     => false,
  ldapserver  => '192.168.42.42',
  ldapbasedn  => 'dc=example,dc=com',
  krb5        => true,
  krb5realm   => 'example.com',
  krb5kdc     => ['kdc1.example.com', 'kdc2.example.com'],
  krb5kadmin  => 'kadmin.example.com',
  cache       => true,
  winbind     => false,
  winbindauth => false,
  smbsecurity => 'ads',
  smbrealm    => 'example.com',
  winbindjoin => 'user@domain%password',
}
```

This will install the authconfig package if necessary and set `ldap` and `ldapauth` to `enable`. It will query the LDAP server located at `ldapserver` address at `ldapbasedn`.
In the mean time it will set `ldaptls` to `disable`. The you can simply do the same for NIS.

In general, if the option is of type `--enableoption/--disableoption` simply set true if you want to enable it, false otherwise.

### Parameters

#### `ldap`

Whether to enable LDAP for user information.

#### `ldapauth`

Whether to enable LDAP for user authentication.

#### `ldaptls`

Whether to enable use of TLS with LDAP.

#### `ldapserver`

LDAP server address to connect to.

#### `ldapbasedn`

LDAP base dn to connet to.

#### `krb5`

Whether to enable Kerberos.

#### `krb5realm`

Specify Kerberos realm.

#### `krb5kdc`

Specify Kerberos KDC

#### `krb5kadmin`

Specify Kerberos administration server

#### `winbind`

Whether to enable Winbind

#### `winbindauth`

Whether to enable Winbind for user authentication

#### `smbsecurity`

The style of Winbind connection. Default: `ads`

#### `smbrealm`

Specify Active Directory realm

#### `winbindjoin`

Specify user credentials of a domain administrator in the form `username@domain%password`

#### `cache`

Whether to use naming services caches

## License

Apache License v2


## Contact

Yanis Guenane - yguenane@gmail.com
