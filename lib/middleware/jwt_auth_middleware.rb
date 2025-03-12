class JwtAuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)


    if public_path?(request.path)
      return @app.call(env)
    end

    token = request.cookies["jwt"]

    if token.present?
      decoded_token = JsonWebToken.decode(token)
      if decoded_token
        env['jwt.payload'] = decoded_token
        return @app.call(env)
      end
    end

    [401, { "Content-Type" => "application/json" }, [{ error: "Unauthorized" }.to_json]]
  end


  private

  def public_path?(path)
    public_routes = [
      "/login"
    ]
    public_routes.include?(path)
  end


end
