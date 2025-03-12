class CreateAuthTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :auth_tokens do |t|
      t.bigint :user_id
      t.string :auth_token

      t.timestamps
    end
  end
end
