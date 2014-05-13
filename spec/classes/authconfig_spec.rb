require 'spec_helper'

describe 'authconfig' do

  context 'EL distributions' do

    let(:facts) do
      {:osfamily => 'RedHat'}
    end

    let(:params) do
      {
       'nis'      => false,
       'shadow'   => true,
       'passalgo' => 'md5',
      }
    end

    it "installs package: authconfig" do
      should contain_package('authconfig')
    end

    context 'LDAP enabled' do
      before :each do
        params.merge!(
          :ldap       => true,
          :ldapauth   => true,
          :ldaptls    => false,
          :ldapserver => '192.168.42.42',
          :ldapbasedn => 'dc=example,dc=com',
        )
      end

      ['openldap-clients', 'nss-pam-ldapd', 'pam_ldap'].each do |package|
        it "installs package: #{package}" do
          should contain_package(package)
        end
      end

      it 'configures service: nslcd' do
        should contain_service('nslcd').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'true',
        })
      end

    end

    context 'Kerberos enabled' do
      before :each do
        params.merge!(
          :krb5       => true,
          :krb5realm  => 'example.com',
          :krb5kdc    => 'kdc1.example.com',
          :krb5kadmin => 'kadmin.example.com',
        )
      end

      ['pam_krb5', 'krb5-workstation'].each do |package|
        it "installs package: #{package}" do
          should contain_package(package)
        end
      end
    end

    context 'Cache enabled' do
      before :each do
        params.merge!(
          :cache => true,
        )
      end

      ['nscd'].each do |package|
        it "installs package: #{package}" do
          should contain_package(package)
        end
      end

      it 'configures service: nscd' do
        should contain_service('nscd').with({
          'ensure'     => 'running',
          'enable'     => 'true',
          'hasstatus'  => 'true',
          'hasrestart' => 'true',
        })
      end

    end


  end

end
