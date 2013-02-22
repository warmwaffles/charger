require 'spec_helper'

describe Charger::Subscription do
  subject { Charger::Subscription.new }

  describe 'fields' do
    it { should respond_to :id }
    it { should respond_to :state }
    it { should respond_to :balance_cents }
    it { should respond_to :current_period_started_at }
    it { should respond_to :current_period_ends_at }
    it { should respond_to :next_assessment_at }
    it { should respond_to :trial_started_at }
    it { should respond_to :trial_ended_at }
    it { should respond_to :activated_at }
    it { should respond_to :expires_at }
    it { should respond_to :created_at }
    it { should respond_to :updated_at }
    it { should respond_to :customer }
    it { should respond_to :product }
    it { should respond_to :credit_card }
    it { should respond_to :cancellation_message }
    it { should respond_to :canceled_at }
    it { should respond_to :signup_revenue }
    it { should respond_to :signup_payment_id }
    it { should respond_to :cancel_at_end_of_peroid }
    it { should respond_to :delayed_cancel_at }
    it { should respond_to :previous_state }
    it { should respond_to :coupon_code }
  end
end
