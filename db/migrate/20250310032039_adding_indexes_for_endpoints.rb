class AddingIndexesForEndpoints < ActiveRecord::Migration[8.0]
  def change
   
    add_index :leaderboards, :total_score            # for sorting by total score
  end
end
