module Charger
  module Resource
    extend ActiveSupport::Concern

    included do
      include Virtus
      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations
      include Request
    end
  end
end
