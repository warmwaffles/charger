module Charger
  class Transaction
    include Resource

    TYPES = %W{charge refund payment credit payment_authorization info adjustment}

    attribute :transaction_type, String
    attribute :id, Integer
    attribute :amount_in_cents, Integer
    attribute :created_at, DateTime
    attribute :ending_balance_in_cents, Integer
    attribute :memo, String
    attribute :subscription_id, Integer
    attribute :product_id, Integer
    attribute :success, Boolean
    attribute :payment_id, Integer
    attribute :kind, String
    attribute :gateway_transaction_id, String

    def subscription
      @subscription ||= Subscription.find(subscription_id)
    end

    def subscription= sub
      @subscription = sub
    end

    def reload
      return false if id.nil?
      self.attributes = client.get("transactions/#{id}")['transaction']
      true
    end

    def self.find id
      new(client.get("transactions/#{id}")['transaction'])
    end

    def self.page params={}
      params = {:page => 1, :per_page => 20}.merge(params)
      transactions = []
      client.get("transactions", params: params).each do |data|
        transactions << new(data['transaction'])
      end
      transactions
    end

    def self.all
      transactions = []
      params = {page: 1, per_page: 200}

      loop do
        response = page(params)
        break if response.empty?
        params[:page] += 1
        transactions += response
      end

      transactions
    end

    # Finds a set of transactions for a subscription
    #
    # Optional Parameters:
    #   * kinds[] : An array of transaction types, see above
    #   * since_id : Returns transactions with an id greater than or equal to
    #     the one specified
    #   * max_id : Returns transactions with an id less than or equal to the one
    #     specified
    #   * since_date : (format YYYY-MM-DD) Returns transactions with a
    #     created_at date greater than or equal to the one specified
    #   * until_date : (format YYYY-MM-DD) Returns transactions with a
    #     created_at date less than or equal to the one specified
    #   * page : default is 1
    #   * per_page : default is 20
    #
    # @param [Integer] id
    # @param [Hash] params See optional params
    # @return [Array<Transaction>]
    def self.find_by_subscription_id id, params={}
      params = {:page => 1, :per_page => 20}.merge(params)
      transactions = []
      loop do
        response = client.get("subscriptions/#{id}/transactions", params: params)
        break if response.empty?
        response.each do |data|
          transactions << new(data['transaction'])
        end
        params[:page] += 1
      end
      transactions
    end
  end
end
