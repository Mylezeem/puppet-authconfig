#Authconfig

[![Build Status](https://travis-ci.org/Mylezeem/puppet-authconfig.png)](https://travis-ci.org/Mylezeem/puppet-authconfig)

A Puppet module that installs and configures authconfig on EL distributions.

It can manage LDAP, NIS, Kerberos and SMB/Winbind related authentication specifics. It also handles enable/disable of caching (nscd).

## Usage

### Simple Usage

```puppet
include authconfig
```

This will install the authconfig package if necessary and set `ldap`, `ldapauth` and `ldaptls` to `disable` by default.

### Custom Usage

```puppet
class { 'authconfig' :
  ldap           => true,
  ldapauth       => true,
  ldaptls        => false,
  ldapserver     => '192.168.42.42',
  ldapbasedn     => 'dc=example,dc=com',
  ldaploadcacert => 'http://www.example.com/certificates/Example_CA.pem'
  sssd           => false,
  sssdauth       => false,
  forcelegacy    => false,
  pamaccess      => false,
  krb5           => true,
  krb5realm      => 'example.com',
  krb5kdc        => ['kdc1.example.com', 'kdc2.example.com'],
  krb5kadmin     => 'kadmin.example.com',
  cache          => true,
  winbind        => false,
  winbindauth    => false,
  smbsecurity    => 'ads',
  smbrealm       => 'example.com',
  smbworkgroup   => 'MYGROUP',
  winbindjoin    => 'user@domain%password',
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

#### `ldaploadcacert`

Loads a CA certificate over HTTP.

#### `passalgo`

Password hashing algorithm

#### `sssd`

Whether to enable SSSD - caches credentials from a remote provider such as LDAP.

#### `sssdauth`

Whether to enable SSSD Auth - Allows users to authenticate from a local cache pulled from a remote provider such as LDAP.

#### `forcelegacy`

Pass true or false, which equate to yes or no - undef will not set the value.  Used in conjunction with SSSD and other caching services.

#### `nis`

Whether to enable NIS for user information.

#### `nisdomain`

NIS Domain

#### `nisserver`

NIS Server

#### `shadow`

Enable shadow password

#### `fingerprint`

Enable fingerprint authentication

#### `pamaccess`

Whether to enable pam access - Allows administrators to configure the authentication process to run the pam_access module during account authorization.

#### `locauthorize`

Whether to bypass checking network authentication services for authorization

#### `sysnetauth`

Whether to allow authentication of system accounts

#### `krb5`

Whether to enable Kerberos.

#### `krb5realm`

Specify Kerberos realm.

#### `krb5kdc`

Specify Kerberos KDC

#### `krb5kadmin`

Specify Kerberos administration server

#### `krb5kdcdns`

Enable use of DNS to find kerberos KDCs

#### `krb5realmdns`

Enable use of DNS to find kerberos realms

#### `preferdns`

Prefer dns over wins or nis for hostname resolution

#### `winbind`

Whether to enable Winbind

#### `winbindauth`

Whether to enable Winbind for user authentication

#### `smbsecurity`

The style of Winbind connection. Default: `ads`

#### `smbrealm`

Specify Active Directory realm

#### `smbworkgroup`

Specify Active Directory workgroup

#### `smbservers`

Specify Active Directory server or servers. Pass a string or an array.

#### `winbindjoin`

Specify user credentials of a domain administrator in the form `username@domain%password`

#### `cache`

Whether to use naming services caches

#### `mkhomedir`

Whether to automatically create user home dir on first login

#### `rfc2307bis`

Boolean to determine if the LDAP schema uses rfc2307 (false) or rfc2307bis (true).
Only valid if `sssd` is true.
If this value is `true` on a system that does not support rfc2307bis (RHEL < 6), a catalog error will be generated.

## License

Apache License v2

## Contact

Yanis Guenane - yguenane@gmail.com
