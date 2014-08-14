class CreateVoteItems < ActiveRecord::Migration
  def change
    create_table :vote_items do |t|
      t.integer :item_type_id
      t.integer :vote_id

      t.timestamps
    end
  end
end
