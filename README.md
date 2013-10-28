#Authconfig [![Build Status](https://travis-ci.org/Spredzy/puppet-authconfig.png)](https://travis-ci.org/Spredzy/puppet-authconfig)

A Puppet module that installs and configure authconfig on EL distribution

**Note**: For this first version it only manage LDAP related authentication specifics.
          Nis, SMB, Winbind, will come in later version. PRs are welcome.

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
    }

This will install the authconfig package if necessary and set `ldap` and `ldapauth` to `enable`. It will query the LDAP server located at `ldapserver` address at `ldapbasedn`.
In the mean time it will set `ldaptls` to `disable`.

## License

Apache License v2


## Contact

Yanis Guenane - yguenane@gmail.com
