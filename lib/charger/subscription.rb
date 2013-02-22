module Charger

  class Subscription
    include Resource

    STATES = %w{trialing trial_ended assessing active soft_failure past_due suspended canceled unpaid expired}

    attribute :id, Integer
    attribute :state, String, default: 'active'
    attribute :balance_cents, Integer
    attribute :current_period_started_at, DateTime
    attribute :current_period_ends_at, DateTime
    attribute :next_assessment_at, DateTime
    attribute :trial_started_at, DateTime
    attribute :trial_ended_at, DateTime
    attribute :activated_at, DateTime
    attribute :expires_at, DateTime
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :customer, Customer
    attribute :product, Product
    attribute :credit_card, CreditCard
    attribute :cancellation_message, String
    attribute :canceled_at, DateTime
    attribute :signup_revenue, Float
    attribute :signup_payment_id, Integer
    attribute :cancel_at_end_of_peroid, Boolean
    attribute :delayed_cancel_at, DateTime
    attribute :previous_state, String
    attribute :coupon_code, String

    validates :state,    inclusion: {in: STATES, allow_blank: true, allow_nil: true}
    validates :product,  presence: true
    validates :customer, presence: true

    # Finds a [Subscription] in chargify. This can raise an exception.
    #
    # @raise [RestClient::Exception] if the id is invalid and the resource is
    #   not found.
    # @return [Subscription]
    def self.find id
      new(client.get("subscriptions/#{id}")['subscription'])
    end

    # This is a **VERY** long running task. It will scrape all of the
    # subscriptions in the chargify account/
    #
    # @return [Array<Subscription>]
    def self.all
      subscriptions = []

      num = 1
      loop do
        subs = page(num, 200)
        break if subs.empty?
        num += 1
        subscriptions += subs
      end

      subscriptions
    end

    # Get all of the subscriptions for a specific page
    #
    # @param [Integer] num default is 1
    # @param [Integer] limit max is 200 and default is 20
    # @return [Array<Subscription>]
    def self.page num=1, limit=20
      subscriptions = []
      client.get("subscriptions", params: {page: num, per_page: limit}).each do |data|
        subscriptions << new(data['subscription'])
      end
      subscriptions
    end

    def live?
      %w{trialing assessing active}.include?(state)
    end

    def trialing?
      state == 'trialing'
    end

    def assessing?
      state == 'assessing'
    end

    def active?
      state == 'active'
    end

    def problem?
      %w{soft_failure past_due unpaid}.include?(state)
    end

    def soft_failure?
      state == 'soft_failure'
    end

    def past_due?
      state == 'past_due'
    end

    def unpaid?
      state == 'unpaid'
    end

    def end_of_life?
      %w{canceled expired suspended trial_ended}.include?(state)
    end

    def canceled?
      state == 'canceled'
    end

    def expired?
      state == 'expired'
    end

    def suspended?
      state == 'suspended'
    end

    def trial_ended?
      state == 'trial_ended'
    end

    # @return [Boolean]
    def persisted?
      !!id
    end

    def activated_on? date
      return false unless activated?
      activated_between?(date.beginning_of_day, date.end_of_day)
    end

    def activated_between? a, b
      return false unless activated?
      activated_at > a && activated_at < b
    end

    def canceled_on? date
      return false unless canceled?
      canceled_between?(date.beginning_of_day, date.end_of_day)
    end

    def canceled_between? a, b
      return false unless canceled?
      canceled_at > a && canceled_at < b
    end

    def total
      sum = product.price_in_cents.to_f / 100.0
      line_items.each do |item|
        sum += item.total if item.allocated?
      end
      sum
    end

    def mrr
      if product.interval_unit == 'day'
        total / (product.interval / 30)
      else
        total / product.interval
      end
    end

    def events force=false
      @events = nil if force
      @events ||= Event.find_by_subscription_id(id)
      @events.each do |event|
        event.subscription = self
      end
      @events
    end

    # @param [Boolean] force will cause this to un-cache the results
    def line_items force=false
      @line_items = nil if force
      @line_items ||= LineItem.find_by_subscription_id(id)
      @line_items.each do |item|
        item.subscription = self
      end
      @line_items
    end

    def transactions force=false
      @transactions = nil if force
      @transactions ||= Transaction.find_by_subscription_id(id)
      @transactions.each do |transaction|
        transaction.subscription = self
      end
      @transactions
    end

    def statements force=false
      @statements = nil if force
      @statements ||= Statement.find_by_subscription_id(id)
      @statements.each do |statement|
        statement.subscription = self
      end
      @statements
    end
  end

end
