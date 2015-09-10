class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :white_player_id
      t.integer :black_player_id
      t.integer :turn
      t.integer :turn_status
      t.integer :chip0_position
      t.integer :chip1_position
      t.integer :chip2_position
      t.integer :chip3_position
      t.integer :chip4_position
      t.integer :chip5_position
      t.integer :chip6_position
      t.integer :chip7_position  
      t.integer :chip8_position
      t.integer :chip9_position
      t.integer :chip10_position
      t.integer :chip11_position
      t.integer :chip12_position
      t.integer :chip13_position
      t.integer :chip14_position
      t.integer :chip15_position 
      t.integer :chip16_position
      t.integer :chip17_position
      t.integer :chip18_position
      t.integer :chip19_position
      t.integer :chip20_position
      t.integer :chip21_position
      t.integer :chip22_position
      t.integer :chip23_position  
      t.integer :chip24_position
      t.integer :chip25_position
      t.integer :chip26_position
      t.integer :chip27_position
      t.integer :chip28_position
      t.integer :chip29_position
      t.timestamps null: false
    end
  end
end
