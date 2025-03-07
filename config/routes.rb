Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post "/api/leaderboard/submit", to: "leaderboard#submit_score"
  get "/api/leaderboard/top", to: "leaderboard#top_players"
  get "/api/leaderboard/rank/:user_id", to: "leaderboard#player_rank"

end
