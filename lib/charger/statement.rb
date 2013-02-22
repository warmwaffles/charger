module Charger
  class Statement
    include Resource

    attribute :id, Integer
    attribute :subscription_id, Integer
    attribute :opened_at, DateTime
    attribute :closed_at, DateTime
    attribute :settled_at, DateTime
    attribute :text_view, String
    attribute :basic_html_view, String
    attribute :html_view, String
    attribute :future_payments, String
    attribute :starting_balance_in_cents, Integer
    attribute :ending_balance_in_cents, Integer
    attribute :customer_first_name, String
    attribute :customer_last_name, String
    attribute :customer_organization, String
    attribute :customer_shipping_address, String
    attribute :customer_shipping_address_2, String
    attribute :customer_shipping_city, String
    attribute :customer_shipping_state, String
    attribute :customer_shipping_country, String
    attribute :customer_shipping_zip, String
    attribute :customer_billing_address, String
    attribute :customer_billing_address_2, String
    attribute :customer_billing_city, String
    attribute :customer_billing_state, String
    attribute :customer_billing_country, String
    attribute :customer_billing_zip, String
    attribute :transactions, Array[Transaction]
    attribute :events, Array[Event]
    attribute :created_at, DateTime
    attribute :updated_at, DateTime

    def subscription
      @subscription ||= Subscription.find(subscription_id)
    end

    def subscription= sub
      @subscription = sub
    end

    def self.find id
      new(client.get("statements/#{id}")['statement'])
    end

    def self.find_by_subscription_id id
      statements = []
      client.get("subscriptions/#{id}/statements").each do |data|
        statements << new(data['statement'])
      end
      statements
    end
  end
end
