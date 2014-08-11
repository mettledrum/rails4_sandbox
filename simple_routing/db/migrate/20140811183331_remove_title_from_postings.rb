class RemoveTitleFromPostings < ActiveRecord::Migration
  def change
    remove_column :postings, :title, :string
  end
end
