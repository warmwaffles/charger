require "charger/version"

module Charger
  class << self
    # Your api key assigned to you buy them
    @@api_key = 'notset'

    # The chargify site
    @@subdomain = 'notset'

    def configure
      yield self
    end
  end

  def self.api_key
    @@api_key
  end

  def self.api_key= api_key
    @@api_key = api_key
  end

  def self.subdomain
    @@subdomain
  end

  def self.subdomain= subdomain
    @@subdomain = subdomain
  end
end
