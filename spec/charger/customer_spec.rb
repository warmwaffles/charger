require 'spec_helper'

describe Charger::Customer do
  subject { Charger::Customer.new }

  describe 'fields' do
    it { should respond_to :id }
    it { should respond_to :first_name }
    it { should respond_to :last_name }
  end


  describe '#persisted?' do
    context 'when the id is set' do
      before { subject.id = 1 }
      it 'should return true' do
        expect(subject.persisted?).to eq(true)
      end
    end
    context 'when the id is not set' do
      it 'should return false' do
        expect(subject.persisted?).to eq(false)
      end
    end
  end
end
