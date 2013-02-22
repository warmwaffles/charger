module Charger

  class Customer
    include Resource

    attribute :id, Integer
    attribute :first_name, String
    attribute :last_name, String

    def persisted?
      !!id
    end
  end

end
