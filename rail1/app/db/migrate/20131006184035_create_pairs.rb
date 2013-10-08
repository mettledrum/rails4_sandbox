class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.integer :dancer1_id,    null: false
      t.integer :dancer2_id,    null: false

      t.timestamps
    end
  end
end
