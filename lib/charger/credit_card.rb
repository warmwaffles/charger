module Charger

  class CreditCard
    include Resource

    VAULTS = %w{cancellation_message trust_commerce payment_express beanstream braintree1}

    attribute :id, Integer
    attribute :payment_profile_id, Integer
    attribute :card_type, String
    attribute :expiration_month, Integer
    attribute :expiration_year, Integer
    attribute :first_name, String
    attribute :last_name, String
    attribute :masked_card_number, String
    attribute :customer_id, Integer
    attribute :customer_vault_token, String
    attribute :vault_token, String
    attribute :current_vault, String
    attribute :billing_address, String
    attribute :billing_address_2, String
    attribute :billing_city, String
    attribute :billing_state, String
    attribute :billing_zip, String
    attribute :billing_country, String

    def persisted?
      !!id
    end
  end

end
