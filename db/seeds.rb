# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


users = User.create!([
  { username: "Alice" },
  { username: "Bob" },
  { username: "Charlie" },
  { username: "David" },
  { username: "Eve" }
])

game_sessions = [
  { user_id: users[0].id, score: 1200, game_mode: "classic" },
  { user_id: users[1].id, score: 1500, game_mode: "classic" },
  { user_id: users[2].id, score: 1100, game_mode: "classic" },
  { user_id: users[3].id, score: 1700, game_mode: "classic" },
  { user_id: users[4].id, score: 900, game_mode: "classic" },
  { user_id: users[1].id, score: 300, game_mode: "arcade" },
  { user_id: users[2].id, score: 500, game_mode: "arcade" }
]

GameSession.create!(game_sessions)

users.each do |user|
  total_score = GameSession.where(user_id: user.id).sum(:score)
  Leaderboard.create!(user_id: user.id, total_score: total_score)
end

Leaderboard.adjust_ranks