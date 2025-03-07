class User < ApplicationRecord
  has_many :game_sessions, dependent: :destroy
  has_one :leaderboard, dependent: :destroy

  validates :username , presence: true, uniqueness: true
end
