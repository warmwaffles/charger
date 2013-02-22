require 'spec_helper'

describe Charger::Price do
  subject { Charger::Price.new }

  describe 'fields' do
    it { should respond_to :ending_quantity }
    it { should respond_to :starting_quantity }
    it { should respond_to :unit_price }
  end

  describe '#between_quantities?' do
    pending 'write these'
  end


  describe '#remaining_quantity' do
    pending 'write these'
  end


  describe '#total' do
    pending 'write these'
  end
end
