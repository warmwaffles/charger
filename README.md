# Charger

A different gem to interact with Chargify's API.

## Installation

```rb
gem 'charger'
```

## Usage

If you are using Rails, you could do the following

```rb
# config/initializers/charger.rb
Charger.configure do |config|
  config.site = {
    subdomain: ENV['CHARGIFY_URL'],
    api_key: ENV['CHARGIFY_TOKEN']
  }
end

# Some other file
mrr = 0.0
at_risk_mrr = 0.0

Charger::Subscription.all.each do |subscription|
  if subscription.live?
    mrr += subscription.mrr
  end
  if subscription.problem?
    at_risk_mrr += subscription.mrr
  end
end

puts "MRR: #{mrr}"
puts "At Risk MRR: #{at_risk_mrr}"
```

For more information on what is available, you'll need to check the source code.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
