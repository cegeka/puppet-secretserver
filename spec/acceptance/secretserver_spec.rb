require 'spec_helper_acceptance'

describe 'secretserver' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include stdlib

        file { '/tmp/ss_get_password':
            ensure  => 'present',
            replace => 'yes',
            content => ss_get_password('ss_get_password-jenkins_test'),
            mode    => '0644',
          }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end
    describe file('/tmp/ss_get_password') do
      it { should contain 'CegekaNV' }
    end
  end
end
