module Charger

  module Request
    extend ActiveSupport::Concern

    included do
      def self.client
        Charger.client
      end

      def client
        Charger.client
      end
    end
  end

end
