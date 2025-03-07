class GameSession < ApplicationRecord
  belongs_to :user

  validates :score, numericality: { greater_than_or_equal_to: 0 }
  validates :game_mode, presence: true
end
