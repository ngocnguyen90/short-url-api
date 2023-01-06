class Rack::Attack
  # `Rack::Attack` is configured to use the `Rails.cache` value by default,
  # but you can override that by setting the `Rack::Attack.cache.store` value
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # Allow all local traffic
  Rack::Attack.safelist('allow from localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Requests are blocked if the return value is truthy
  Rack::Attack.blocklist('block 1.2.3.4') do |req|
    '1.2.3.4' == req.ip
  end

  # Allow an IP address to make 5 requests every 5 seconds
  Rack::Attack.throttle('req/ip', limit: 5, period: 1.second) do |req|
    req.ip
  end

  # Send the following response to blocklisted clients
  Rack::Attack.blocklisted_responder = lambda do |_env|
    [403, {}, ['Blocked']]
  end

  # Send the following response to throttled clients
  Rack::Attack.throttled_responder = lambda do |_env|
    [503, {}, ["Server Error\n"]]
  end
end
