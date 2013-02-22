require 'virtus'
require 'active_support'
require 'active_model'
require 'rest-client'
require 'json'

require 'charger/exception'
require 'charger/resource'
require 'charger/request'
require 'charger/price'
require 'charger/component'
require 'charger/component/metered'
require 'charger/component/on_off'
require 'charger/component/quantity_based'
require 'charger/credit_card'
require 'charger/customer'
require 'charger/event'
require 'charger/line_item'
require 'charger/product_family'
require 'charger/product'
require 'charger/transaction'
require 'charger/statement'
require 'charger/subscription'
require 'charger/line_item/metered'
require 'charger/line_item/on_off'
require 'charger/line_item/quantity_based'
require 'charger/client'
require 'charger/configuration'

module Charger
  class << self
    # The hash of configurations
    @@configurations = {}

    # The current client
    @@current = nil

    def configure
      yield self
    end
  end

  # Add a configuration to Charger
  #
  # @param [Hash] params
  # @return [void]
  def self.site= params={}
    return unless params[:subdomain] || params[:api_key]
    config = Configuration.new(params)
    @@configurations[config.subdomain] = config
    @@current = config
  end

  # Switches between configurations. Useful if you want to connect to multiple
  # chargify accounts at once.
  #
  # @return [Boolean]
  def self.switch subdomain
    @@current = @@configurations[subdomain]
    true
  rescue
    false
  end

  # Clears all configurations
  #
  # @return [void]
  def self.clear
    @@configurations = Hash.new
    @@current = nil
  end

  # @return [Charger::Client]
  def self.client
    @@current.client
  rescue
    nil
  end

  def self.configurations
    @@configurations
  end

  def self.current
    @@current
  end

end
