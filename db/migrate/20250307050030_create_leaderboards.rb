class CreateLeaderboards < ActiveRecord::Migration[8.0]
  def change
    create_table :leaderboards do |t|
      t.references :user, index: {unique: true}, null: false, foreign_key: true
      t.integer :total_score, null: false, default: 0
      t.integer :rank

      t.timestamps
    end
  end
end
