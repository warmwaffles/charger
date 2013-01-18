module Charger

  class Component::OnOff < Component
    def total_for val
      val > 0 ?  unit_price : 0.to_f
    end
  end

end
