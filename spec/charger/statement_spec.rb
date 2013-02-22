require 'spec_helper'

describe Charger::Statement do
  subject { Charger::Statement.new }

  describe 'fields' do
    it { should respond_to :id }
    it { should respond_to :subscription_id }
    it { should respond_to :opened_at }
    it { should respond_to :closed_at }
    it { should respond_to :settled_at }
    it { should respond_to :text_view }
    it { should respond_to :basic_html_view }
    it { should respond_to :html_view }
    it { should respond_to :future_payments }
    it { should respond_to :starting_balance_in_cents }
    it { should respond_to :ending_balance_in_cents }
    it { should respond_to :customer_first_name }
    it { should respond_to :customer_last_name }
    it { should respond_to :customer_organization }
    it { should respond_to :customer_shipping_address }
    it { should respond_to :customer_shipping_address_2 }
    it { should respond_to :customer_shipping_city }
    it { should respond_to :customer_shipping_state }
    it { should respond_to :customer_shipping_country }
    it { should respond_to :customer_shipping_zip }
    it { should respond_to :customer_billing_address }
    it { should respond_to :customer_billing_address_2 }
    it { should respond_to :customer_billing_city }
    it { should respond_to :customer_billing_state }
    it { should respond_to :customer_billing_country }
    it { should respond_to :customer_billing_zip }
    it { should respond_to :transactions }
    it { should respond_to :events }
    it { should respond_to :created_at }
  end
end
