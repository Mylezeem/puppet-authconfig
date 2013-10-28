require 'spec_helper'

describe 'authconfig' do

  context 'EL distributions' do

    let(:facts) do
      {:osfamily => 'RedHat'}
    end

    let(:params) do
      {'ldap'     => true,
       'ldapauth' => true,
       'ldaptls'  => false,
       'nis'      => false,
       'shadow'   => true,
       'md5'      => false}
    end

    it 'installs authconfig package' do
      should contain_package('authconfig')
    end

    it 'execute authconfig update command' do
      should contain_exec('authconfig command').with({
        'command' => 'authconfig --enableldap --enableldapauth --disableldaptls   --disablenis   --disablemd5 --enableshadow --update',
      })
    end

  end

end
