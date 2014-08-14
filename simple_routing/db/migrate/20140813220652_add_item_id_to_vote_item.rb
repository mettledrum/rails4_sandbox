class AddItemIdToVoteItem < ActiveRecord::Migration
  def change
    add_column :vote_items, :item_id, :integer
  end
end
