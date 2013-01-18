module Charger

  class LineItem::Metered < LineItem
    attribute :unit_balance, Integer

    # @return [Float]
    def total
      component.total_for(unit_balance)
    end

    # @return [Boolean]
    def allocated?
      unit_balance > 0
    end
  end

end
