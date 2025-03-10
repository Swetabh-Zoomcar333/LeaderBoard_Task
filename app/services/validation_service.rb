class ValidationService
  def self.validate_params(params)


    allowed_modes = %w[arcade classic solo ranked team]
    errors = Array.new
    
    errors << "Missing parameteres" unless params[:user_id].present? && params[:score].present? && params[:game_mode].present?
    errors << "Score must be a positive integer less than equal to 1000" unless params[:score].to_i.positive? && params[:score].to_i <= 1000
    errors <<  "Invalid game_mode" unless allowed_modes.include?(params[:game_mode])

    errors.empty? ? nil:errors

  end
end