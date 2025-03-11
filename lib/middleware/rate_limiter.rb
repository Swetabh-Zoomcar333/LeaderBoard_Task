class RateLimiter
  
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    ip = request.ip 
    key = "rate_limit:#{ip}"

    limit = 10

    count_reqs = RedisClient.get(key).to_i

    if count_reqs >= limit
      return [429,{ "Content-Type:" => "application/json"}, [{ error: "Rate limit exceeded"}.to_json]]
    else
      RedisClient.multi do
        RedisClient.incr(key)
        RedisClient.expire(key,60) if count_reqs.zero?
      end
    end

    @app.call(env)
  end

end