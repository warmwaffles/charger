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
