module Charger

  class LineItem::QuantityBased < LineItem
    attribute :allocated_quantity, Integer

    # @return [Float]
    def total
      component.total_for(allocated_quantity)
    end

    # @return [Boolean]
    def allocated?
      allocated_quantity > 0
    end
  end

end
