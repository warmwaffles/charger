require "charger/version"

module Charger
  class << self
    attr_accessor :api_key, :subdomain

    def configure
      yield self
    end
  end
end
