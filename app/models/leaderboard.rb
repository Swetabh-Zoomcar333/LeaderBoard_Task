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
    # Leaderboard.order(total_score: :desc).each_with_index do |record,index|
    #   record.update(rank: index+1)
    # end


    update_query =  <<-SQL
      with ranked as ( select id, rank() over(order by total_score desc) as new_rank from leaderboards)
      update leaderboards set rank = ranked.new_rank from ranked where leaderboards.id = ranked.id and leaderboards.rank is distinct from ranked.new_rank;
    SQL

    ActiveRecord::Base.connection.exec_query(update_query)

  end

end
