require_relative "boot"

require "rails/all"

require_relative "../lib/middleware/jwt_auth_middleware"
require_relative "../lib/middleware/rate_limiter"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LeaderboardTask
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.

    #rate-limiter

    config.eager_load_paths << Rails.root.join("lib","middleware")


    #config.middleware.insert_before 0, RateLimiter

    config.middleware.use RateLimiter
    config.middleware.use JwtAuthMiddleware

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_your_app_session'

    config.action_dispatch.cookies_same_site_protection = :none

    config.api_only = true
  end
end
