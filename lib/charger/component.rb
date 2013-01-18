module Charger

  class Component
    include Virtus
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attribute :id, Integer
    attribute :name, String
    attribute :unit_name, String
    attribute :unit_price, Float
    attribute :pricing_scheme, String
    attribute :prices, Array[Component::Price]
    attribute :product_family_id, Integer
    attribute :kind, String
    attribute :archived, Boolean

    def total_for amount
      prices.sort_by! { |k| k.starting_quantity }

      total = 0.0

      case pricing_scheme
      when 'per_unit'
        total = amount * unit_price
      when 'volume'
        total = amount * prices.select { |price| price.between_quantities?(amount) }.unit_price
      when 'tiered'
        prices.each do |price|
          total += price.total(amount)
        end
      when 'stairstep'
        total = prices.select { |price| price.between_quantities?(amount) }.unit_price
      end

      total
    rescue => e
      puts "[ERROR] #{e}"
      puts "[ERROR] #{amount}"
      puts "[ERROR] #{self.to_json}"
      return 0.0
    end

    def self.find_by_product_family_id id
      client = Client.new
      components = []

      client.get("product_families/#{id}/components").each do |data|
        case data['component']['kind']
        when 'quantity_based_component'
          components << Component::QuantityBased.new(data['component'])
        when 'metered_component'
          components << Component::Metered.new(data['component'])
        when 'on_off_component'
          components << Component::OnOff.new(data['component'])
        end
      end

      components
    end

    def self.find product_family_id, id
      client = Client.new
      new(client.get("product_families/#{product_family_id}/components/#{id}")['component'])
    end
  end

end
