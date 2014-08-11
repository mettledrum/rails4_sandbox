class AddPostingIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :posting_id, :integer
  end
end
