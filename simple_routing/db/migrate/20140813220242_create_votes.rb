class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :value
      t.integer :item_id
      t.integer :item_type_id

      t.timestamps
    end
  end
end
