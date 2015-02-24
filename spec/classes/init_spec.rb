require 'spec_helper'
describe 'rkhunter' do

  context 'with defaults for all parameters' do
    it { should contain_class('rkhunter') }
  end
end
