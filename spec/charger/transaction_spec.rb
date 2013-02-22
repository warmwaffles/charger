require 'spec_helper'

describe Charger::Transaction do
  subject { Charger::Transaction.new }

  describe 'fields' do
    it { should respond_to :transaction_type }
    it { should respond_to :id }
    it { should respond_to :amount_in_cents }
    it { should respond_to :created_at }
    it { should respond_to :ending_balance_in_cents }
    it { should respond_to :memo }
    it { should respond_to :subscription_id }
    it { should respond_to :product_id }
    it { should respond_to :success }
    it { should respond_to :payment_id }
    it { should respond_to :kind }
    it { should respond_to :gateway_transaction_id }
  end

  describe '#subscription' do
    it { should respond_to :subscription }
  end


  describe '#subscription=' do
    it { should respond_to :subscription= }
  end


  describe '#reload' do
    it { should respond_to :reload }
  end


  describe '.find' do
    subject { Charger::Transaction }
    it { should respond_to :find }
  end


  describe '.page' do
    subject { Charger::Transaction }
    it { should respond_to :page }
  end


  describe '.all' do
    subject { Charger::Transaction }
    it { should respond_to :all }
  end


  describe '.find_by_subscription_id' do
    subject { Charger::Transaction }
    it { should respond_to :find_by_subscription_id }
  end
end
