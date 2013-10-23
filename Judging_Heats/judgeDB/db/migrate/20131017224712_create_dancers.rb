class CreateDancers < ActiveRecord::Migration
  def change
    create_table :dancers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
