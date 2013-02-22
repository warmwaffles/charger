require 'spec_helper'

describe Charger::Configuration do
  subject { Charger::Configuration.new }

  describe 'fields' do
    it { should respond_to :api_key }
    it { should respond_to :subdomain }
  end
end
