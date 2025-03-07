class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.datetime :join_date, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
