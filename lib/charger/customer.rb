module Charger

  class Customer
    include Virtus
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attribute :id, Integer
    attribute :first_name, String
    attribute :last_name, String

    def persisted?
      !!id
    end
  end

end
