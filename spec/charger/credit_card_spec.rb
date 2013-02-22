require 'spec_helper'

describe Charger::CreditCard do
  subject { Charger::CreditCard.new }

  describe 'fields' do
    it { should respond_to :id }
    it { should respond_to :payment_profile_id }
    it { should respond_to :card_type }
    it { should respond_to :expiration_month }
    it { should respond_to :expiration_year }
    it { should respond_to :first_name }
    it { should respond_to :last_name }
    it { should respond_to :masked_card_number }
    it { should respond_to :customer_id }
    it { should respond_to :customer_vault_token }
    it { should respond_to :vault_token }
    it { should respond_to :current_vault }
    it { should respond_to :billing_address }
    it { should respond_to :billing_address_2 }
    it { should respond_to :billing_city }
    it { should respond_to :billing_state }
    it { should respond_to :billing_zip }
    it { should respond_to :billing_country }
  end


  describe '#persisted?' do
    context 'when id is not set' do
      it 'should return false' do
        expect(subject.persisted?).to eq(false)
      end
    end

    context 'when id is set' do
      before { subject.id = 1 }
      it 'should return true' do
        expect(subject.persisted?).to eq(true)
      end
    end
  end
end
