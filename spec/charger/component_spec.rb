require 'spec_helper'

describe Charger::Component do
  subject { Charger::Component.new }

  describe 'attributes' do
    it { should respond_to :id }
    it { should respond_to :name }
    it { should respond_to :unit_name }
    it { should respond_to :unit_price }
    it { should respond_to :pricing_scheme }
    it { should respond_to :prices }
    it { should respond_to :product_family_id }
    it { should respond_to :kind }
    it { should respond_to :archived }
  end


  describe '#total_for' do
    it { should respond_to :total_for}
  end


  describe '.find_by_product_family_id' do
    subject { Charger::Component }
    it { should respond_to :find_by_product_family_id }
  end


  describe '.find' do
    subject { Charger::Component }
    it { should respond_to :find }
  end

end
