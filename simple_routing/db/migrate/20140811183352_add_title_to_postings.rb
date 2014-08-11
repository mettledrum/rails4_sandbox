class AddTitleToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :title, :string
  end
end
