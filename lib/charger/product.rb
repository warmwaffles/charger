module Charger

  class Product
    include Virtus
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attribute :id, Integer
    attribute :price_in_cents, Integer
    attribute :name, String
    attribute :handle, String
    attribute :description, String
    attribute :product_family, ProductFamily
    attribute :accounting_code, String
    attribute :interval_unit, String
    attribute :interval, Integer
    attribute :initial_charge_in_cents, Integer
    attribute :trial_price_in_cents, Integer
    attribute :trial_interval, Integer
    attribute :trial_interval_unit, String
    attribute :expiration_interval, Integer
    attribute :expiration_interval_unit, String
    attribute :return_url, String
    attribute :return_params, String
    attribute :required_credit_card, Boolean
    attribute :request_credit_card, Boolean
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :archived_at, DateTime

    def self.find_by_product_family_id id
      client = Client.new
      products = []
      client.get("product_families/#{id}/products") do |data|
        products << new(data['product'])
      end
      products
    end

    def persisted?
      !!id
    end
  end

end
