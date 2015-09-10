class CreateFoes < ActiveRecord::Migration
  def change
    create_table :foes do |t|
      t.integer :foe_requester_id
      t.integer :foe_responder_id
      t.integer :status
      t.timestamps null: false
    end
  end
end
