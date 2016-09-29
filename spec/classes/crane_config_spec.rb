require 'spec_helper'

describe 'crane' do
  on_supported_os.each do |os, facts|
    context "os #{os}" do
      let(:facts) { facts }

      context 'with no parameters' do
        let :pre_condition do
          "class {'crane':}"
        end

        it "should set up the config file" do
          should contain_file('/etc/crane.conf').
            with({
              'ensure'  => 'file',
              'owner'   => 'root',
              'group'   => 'root',
              'mode'    => '0644',
            }).
            with_content(/^endpoint: foo.example.com:5000$/)
        end
      end

      context 'with parameters' do
        let :pre_condition do
          "class {'crane':
            port => 5001
          }"
        end

        it "should set the port" do
          should contain_file('/etc/crane.conf').
            with_content(/^endpoint: foo.example.com:5001$/)
        end
      end

      context 'with data dir ' do
        let :pre_condition do
          "class {'crane':
            data_dir => 'foo'
          }"
        end

        it "should set the data_dir" do
          should contain_file('/etc/crane.conf').
            with_content(/^data_dir: foo$/)
        end
      end
    end
  end
end
