class Leaderboard < ApplicationRecord
  belongs_to :user

  validates :total_score, numericality: { greater_than_or_equal_to: 0 }

  #this is to take a particuar user id and update it's score
  def self.update_leaderboard(user_id,score)
    leaderboard_entry = Leaderboard.find_or_initialize_by(user_id: user_id)
    leaderboard_entry.total_score = leaderboard_entry.total_score || 0
    leaderboard_entry.total_score += score
    leaderboard_entry.save
  end

  def self.adjust_ranks
    Leaderboard.order(total_score: :desc).each_with_index do |record,index|
      record.update(rank: index+1)
    end
  end

end
