class LeaderboardService
  def self.submit_score(user_id,score,game_mode)
    user = User.find(user_id)
    GameSession.create!(user: user, score: score, game_mode: game_mode)

    Leaderboard.update_leaderboard(user.id, score)
    Leaderboard.adjust_ranks

  end

  def self.top_players
    Leaderboard.order(total_score: :desc).limit(10).includes(:user)
  end

  def self.player_rank(user_id)
    player = Leaderboard.find_by(user_id: user_id)
    player&.rank || "Not ranked now"
  end

end