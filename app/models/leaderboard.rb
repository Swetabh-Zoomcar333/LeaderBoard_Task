class Leaderboard < ApplicationRecord
  belongs_to :user

  validates :total_score, numericality: { greater_than_or_equal_to: 0 }

  #this is to take a particuar user id and update it's score
  def update_leaderboard!(score)
    self.total_score += score
    save!
  end

  def adjust_ranks!

   old_rank = rank
   new_rank = Leaderboard.where("total_score > ?",total_score).count + 1
   Leaderboard.where("rank >= ? and rank < ?",new_rank,old_rank).update_all("rank = rank + 1")
   update(rank: new_rank)


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
