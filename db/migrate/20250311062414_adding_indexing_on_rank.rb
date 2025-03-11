class AddingIndexingOnRank < ActiveRecord::Migration[8.0]
  def change
    add_index :leaderboards, :rank
  end
end
