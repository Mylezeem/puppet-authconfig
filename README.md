#Authconfig [![Build Status](https://travis-ci.org/Spredzy/puppet-authconfig.png)](https://travis-ci.org/Spredzy/puppet-authconfig)

A Puppet module that installs and configure authconfig on EL distribution

**Note**: For this first version it only manages LDAP, NIS, and Kerberos related authentication specifics.  It also handles enable/disable of cacheing (nscd).
          SMB, Winbind, will come in later version. PRs are welcome.

## Usage

### Simple Usage

    include authconfig

This will install the authconfig package if necessary and set `ldap`, `ldapauth` and `ldaptls` to `disable` by default.

### Custom Usage

    class {'authconfig' :
      ldap        => true,
      ldapauth    => true,
      ldaptls     => false,
      ldapserver  => '192.168.42.42',
      ldapbasedn  => 'dc=example,dc=com',
      krb5	  => true,
      krb5realm   => 'EXAMPLE.COM',
      krb5kdc     => [ 'kdc1.example.com', 'kdc2.example.com'],
      krb5kadmin  => 'kadmin.example.com',
      cache 	  => true,
    }

This will install the authconfig package if necessary and set `ldap` and `ldapauth` to `enable`. It will query the LDAP server located at `ldapserver` address at `ldapbasedn`.
In the mean time it will set `ldaptls` to `disable`. The you can simply do the same for NIS.

In general, if the option is of type `--enableoption/--disableoption` simply set true if you want to enable it, false otherwise.

## License

Apache License v2


## Contact

Yanis Guenane - yguenane@gmail.com
