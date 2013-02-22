module Charger

  class ProductFamily
    include Resource

    attribute :id, Integer
    attribute :name, String
    attribute :handle, String
    attribute :accounting_code, String
    attribute :description, String

    validates :name,   presence: true
    validates :handle, presence: true

    # @param [Boolean] force will cause this to un-cache the results
    def products force=false
      @products = nil if force
      @products ||= Product.find_by_product_family_id(id)
    end

    # Get all of the components descriptions associated to this product family
    #
    # @param [Boolean] force will cause this to un-cache the results
    # @return [Array<Component>]
    def components force=false
      @components = nil if force
      @components ||= Component.find_by_product_family_id(id)
    end

    def persisted?
      !!id
    end
  end

end
