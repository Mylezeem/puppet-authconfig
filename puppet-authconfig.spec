Name:           puppet-authconfig
Version:        0.2.0
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
* Mon May 12 2014  Yanis Guenane  <yguenane@gmail.com>  0.2.0
- Support for Kerberos (@radioactiv)
- Run only if change is made (@radioactiv)
* Mon Oct 5 2013  Yanis Guenane  <yguenane@gmail.com>  0.1.0
- Initial version

