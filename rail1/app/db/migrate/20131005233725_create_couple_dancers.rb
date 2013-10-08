class CreateCoupleDancers < ActiveRecord::Migration
  def change
    create_table :couple_dancers do |t|
      t.belongs_to :dancer
      t.belongs_to :couple 
      t.timestamps
    end
  end
end
