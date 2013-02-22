require 'spec_helper'

describe Charger::ProductFamily do
  subject { Charger::ProductFamily.new }

  describe 'fields' do
    it { should respond_to :id }
    it { should respond_to :name }
    it { should respond_to :handle }
    it { should respond_to :accounting_code }
    it { should respond_to :description }
  end
end
