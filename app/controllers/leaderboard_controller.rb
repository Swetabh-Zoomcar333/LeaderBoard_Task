class LeaderboardController < ApplicationController

  before_action :validate_params, only: [:submit_score]

  def submit_score

    LeaderboardService.submit_score(params[:user_id],params[:score].to_i,params[:game_mode])
    render json: { message: "Updated score and leaderboard!" }

  end

  def top_players
    top = LeaderboardService.top_players
    render json: top, include: :user
  end

  def player_rank
    rank = LeaderboardService.player_rank(params[:user_id])
    render json: { rank: rank }
  end

  private

  def validate_params
    render json: { error: "Missing parameters" }, status: 400 unless params[:user_id] && params[:score] && params[:game_mode]
  end

end