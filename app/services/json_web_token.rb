require 'jwt'

class JsonWebToken
  SECRET_KEY = ENV['JWT_SECRET_KEY']

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY,'HS256')
  end

  def self.decode(token)
    payload = JWT.decode(token, SECRET_KEY, true, {algorithm: 'HS256' })[0]
    puts "payload #{payload}"
    HashWithIndifferentAccess.new(payload)
  end
end
