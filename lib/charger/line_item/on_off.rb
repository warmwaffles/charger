module Charger

  class LineItem::OnOff < LineItem
    attribute :enabled, Boolean

    # @return [Float]
    def total
      if enabled
        component.total_for(1)
      else
        0
      end
    end

    # @return [Boolean]
    def allocated?
      enabled
    end
  end

end
