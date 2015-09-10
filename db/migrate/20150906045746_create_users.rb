class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :password
      t.string  :username
      t.integer :logged_in
      t.time    :last_activity
      t.integer :num_games
      t.integer :num_wins
      t.timestamps null: false
    end
  end
end
