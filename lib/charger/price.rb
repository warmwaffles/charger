module Charger

  class Price
    include Virtus

    attribute :ending_quantity,   Integer
    attribute :starting_quantity, Integer, default: 0
    attribute :unit_price,        Float

    def between_quantities? amount
      if ending_quantity
        starting_quantity <= amount && ending_quantity >= amount
      else
        starting_quantity <= amount
      end
    end

    def remaining_quantity amount
      if ending_quantity
        amount - ending_quantity
      else
        amount
      end
    end

    def total amount
      return 0.0 if amount < starting_quantity
      if ending_quantity && amount > ending_quantity
        ending_quantity * unit_price
      else
        (amount - (starting_quantity-1)) * unit_price
      end
    end
  end

end
