module Charger

  class Configuration
    include Virtus

    attribute :api_key, String
    attribute :subdomain, String

    # Retrieves this Configuration's client
    #
    # @return [Charger::Client]
    def client
      Client.new(api_key, subdomain)
    end
  end

end
