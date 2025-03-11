class LeaderboardService
  def self.submit_score(user_id,score,game_mode)
    user = User.find(user_id)
    
    ActiveRecord::Base.transaction do
      GameSession.create!(user: user, score: score, game_mode: game_mode)
      old_score, new_score = Leaderboard.update_leaderboard(user.id, score)
      Leaderboard.adjust_ranks(user.id,old_score,new_score)
    end

    RedisClient.del("top_players")
    RedisClient.del("player_rank_#{user_id}")

  end

  def self.top_players
    cached_top = RedisClient.get("top_players")
    if cached_top 
      JSON.parse(cached_top)
    else
      top_players = Leaderboard.where(rank: 1..10).includes(:user)
      RedisClient.set("top_players",top_players.to_json)
      top_players
    end   
  end

  def self.player_rank(user_id)
    cached_rank = RedisClient.get("player_rank_#{user_id}")
    if cached_rank
      cached_rank.to_i
    else
      player = player = Leaderboard.find_by(user_id: user_id)
      rank = player&.rank || "Not ranked now"
      RedisClient.set("player_rank_#{user_id}",rank.to_s)
      rank
    end
  end
end