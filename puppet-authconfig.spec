Name:           puppet-authconfig
Version:        0.6.0
Release:        1%{?dist}
Summary:        A puppet module that installs and configure authconfig

Group:          System Environment/Libraries
License:        Apache v2
URL:            http://forge.puppetlabs.com/yguenane/authconfig
Source0:        http://forge.puppetlabs.com/yguenane/authconfig/%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires:       puppet

%description
This Puppet module allows you to configure Network Authentication Access via authconfig

%prep
%setup -n yguenane-authconfig-%{version}

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/etc/puppet/modules/authconfig/
cp -r lib manifests $RPM_BUILD_ROOT/etc/puppet/modules/authconfig/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%{_sysconfdir}/puppet/modules/*
%doc CHANGELOG README LICENSE

%changelog
* Thu Feb 26 2015  Yanis Guenane  <yguenane@gmail.com> 0.6.0
- Add support for ssd, ssd_auth, pamaccess, forcelegacy (@Z3r0Sum)
- Modify PATH to the authconfig exec command so /usr/sbin/cacertdir_rehash will work (@lorenjanwilson)
- Better support for EL5 based OS (@GerbenWelter, @ofalk)
- Better support for mkhomedir flag (@GerbenWelter)
* Mon Nov 3 2014  Yanis Guenane  <yguenane@gmail.com>  0.5.0
- Fix ordering issue (@gillesgagniard)
- Add support for RHEL7 (@gillesgagniard)
- Add support for parameter mkhomedir (@gillesgagniard)
- Add support for parameter ldaploadcacert (@rhartkopf)
- Add support for parameters krb5kdcdns, krb5realmdns, preferdns (@djjudas21)
* Mon Sep 1 2014  Yanis Guenane  <yguenane@gmail.com>  0.4.1
- Add support for parameter smbworkgroup (@djjudas21)
* Tue Aug 19 2014  Yanis Guenane  <yguenane@gmail.com>  0.4.0
- Support for SMB and Winbind (@djjudas21)
* Fri Jul 25 2014  Yanis Guenane  <yguenane@gmail.com>  0.3.0
- Support for NIS (@DarrinC)
- Use of metadata.json for forge filtering
* Mon May 12 2014  Yanis Guenane  <yguenane@gmail.com>  0.2.0
- Support for Kerberos (@radioactiv)
- Run only if change is made (@radioactiv)
* Mon Oct 5 2013  Yanis Guenane  <yguenane@gmail.com>  0.1.0
- Initial version

