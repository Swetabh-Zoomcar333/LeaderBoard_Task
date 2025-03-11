class Leaderboard < ApplicationRecord
  belongs_to :user

  validates :total_score, numericality: { greater_than_or_equal_to: 0 }

  #this is to take a particuar user id and update it's score
  def self.update_leaderboard(user_id,score)
    leaderboard_entry = Leaderboard.find_by(user_id: user_id)
    old_score = leaderboard_entry.total_score || 0
    new_score = old_score + score
    leaderboard_entry.save!
    return old_score, new_score
  end

  def self.adjust_ranks(user_id,old_score,new_score)

    ActiveRecord::Base.transaction do
      leaderboard_entry = Leaderboard.find_by(user_id: user_id)
      old_rank = leaderboard_entry.rank;
      new_rank = Leaderboard.where("total_score > ?",new_score).count + 1
      Leaderboard.where("rank >= ? and rank < ?",new_rank, old_rank).update_all("rank = rank + 1")
      leaderboard_entry.update!(rank:new_rank,total_score: new_score)
    end
    # Leaderboard.order(total_score: :desc).each_with_index do |record,index|
    #   record.update(rank: index+1)
    # end


    # update_query =  <<-SQL
    #   with ranked as ( select id, rank() over(order by total_score desc) as new_rank from leaderboards)
    #   update leaderboards set rank = ranked.new_rank from ranked where leaderboards.id = ranked.id and leaderboards.rank is distinct from ranked.new_rank;
    # SQL

    # ActiveRecord::Base.connection.exec_query(update_query)
  end
end
