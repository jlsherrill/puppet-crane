require 'spec_helper'

describe 'crane' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { should contain_class('crane::install') }
      it { should contain_class('crane::config') }
    end
  end
end
