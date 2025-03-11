class ValidationService < Dry::Validation::Contract
  params do
    required(:user_id).filled(:integer)
    required(:score).filled(:integer,gt?:0,lteq?:1000)
    required(:game_mode).filled(:string,included_in?: %w[arcade classic solo team ranked])
  end
end