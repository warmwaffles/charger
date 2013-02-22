module Charger

  class LineItem
    include Resource

    attribute :subscription_id, Integer
    attribute :component_id, Integer
    attribute :name, String
    attribute :unit_name, String
    attribute :kind, String

    # @param [Integer] id the id of the subscription
    # @return [Array<LineItem>]
    def self.find_by_subscription_id id
      items = []

      client.get("subscriptions/#{id}/components").each do |data|
        case data['component']['kind']
        when 'metered_component'
          items << LineItem::Metered.new(data['component'])
        when 'quantity_based_component'
          items << LineItem::QuantityBased.new(data['component'])
        when 'on_off_component'
          items << LineItem::OnOff.new(data['component'])
        end
      end

      items
    end

    # @return [Float]
    def total
      0.0
    end

    def subscription= sub
      @subscription = sub
    end

    # @param [Boolean] force uncache the results from chargify
    # @return [Subscription]
    def subscription force=false
      @subscription = nil if force
      @subscription ||= Subscription.find(subscription_id)
    end

    def component= comp
      @component = comp
    end

    # @param [Boolean] force uncache the results from chargify
    # @return [Component]
    def component force=false
      @component = nil if force

      unless @component
        product = subscription.product
        family = product.product_family
        @component = Component.find(family.id, component_id)
      end

      @component
    end

    # @return [Boolean]
    def allocated?
      false
    end
  end

end
