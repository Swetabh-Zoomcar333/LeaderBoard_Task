class AddCascadingDeleteToUserId < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :leaderboards, :users
    remove_foreign_key :game_sessions, :users

    add_foreign_key :leaderboards, :users, on_delete: :cascade
    add_foreign_key :game_sessions, :users, on_delete: :cascade
  end
end
