module Charger

  class Event
    include Resource

    attribute :id, Integer
    attribute :key, String
    attribute :message, String
    attribute :subscription_id, Integer
    attribute :event_specific_data, Hash
    attribute :created_at, DateTime

    def subscription force=false
      @subscription = nil if force
      @subscription ||= Subscription.find(subscription_id)
    end

    def subscription= val
      @subscription = val
    end

    # Grabs ALL of the events. Note this is a LONG running task especially if
    # your account has a lot of events. You can shorten it up by passing in some
    # optional parameters.
    #
    # Parameters Available:
    #   * per_page
    #   * since_id
    #   * max_id
    #   * direction - default is `desc`
    #
    # @param [Hash] params
    # @return [Array<Event>]
    def self.all params={}
      params = { per_page: 200, direction: 'desc' }.merge(params)
      events = []
      num = 1
      loop do
        params[:page] = num
        response = page(params)
        break if response.empty?
        num += 1
        events += response
        puts num
      end
      events
    end

    # Gets a single page of events
    # Parameters available:
    #   * page
    #   * per_page
    #   * since_id
    #   * max_id
    #   * direction - `asc` and `desc` are valid
    # @param [Hash] params
    def self.page params={}
      params = { page: 1, per_page: 25, direction: 'desc' }.merge(params)
      events = []
      client.get('events', params: params).each do |data|
        events << new(data['event'])
      end
      events
    end

    def self.find_by_subscription_id sub, params={}
      params = { per_page: 200, direction: 'desc' }.merge(params)
      events = []
      client.get("subscriptions/#{sub}/events", params).each do |data|
        events << new(data['event'])
      end
      events
    end

  end

end
