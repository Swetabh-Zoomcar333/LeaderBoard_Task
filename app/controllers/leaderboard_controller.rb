class LeaderboardController < ApplicationController

  def submit_score
    user = User.find(params[:user_id])
    score = params[:score].to_i

    GameSession.create!(user:user, score:score, game_mode: params[:game_mode])

    Leaderboard.update_leaderboard(user.id,score)

    Leaderboard.adjust_ranks

    render json: { message: "Updated score and leaderboard!" }

  end

  def top_players
    top = Leaderboard.order(total_score: :desc).limit(10)
    render json: top, include: :user
  end

  def player_rank
    player = Leaderboard.find_by(user_id: params[:user_id])
    render json: { rank: player&.rank || "Not ranked now" }
  end
  

end