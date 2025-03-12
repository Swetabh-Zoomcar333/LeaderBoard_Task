class LeaderboardController < ApplicationController

  before_action :validate_params, only: [:submit_score]

  def submit_score

    LeaderboardService.new(@validated_params[:user_id],@validated_params[:score].to_i,@validated_params[:game_mode]).submit_score
    render json: { message: "Updated score and leaderboard!" }

  end

  def top_players
    top = LeaderboardService.top_players
    render json: top
  end

  def player_rank
    rank = LeaderboardService.player_rank(params[:user_id])
    render json: { rank: rank }
  end

  private

  def validate_params
    # errors = ValidationService.validate_params(params)
    # render json: {error: errors}, status:400 if errors
    validation =ValidationService.new.call(params.to_unsafe_h)
    if validation.success?
      @validated_params = validation.to_h
    else
      render json: {errord: validation.errors.to_h},status:400
    end
  end

end