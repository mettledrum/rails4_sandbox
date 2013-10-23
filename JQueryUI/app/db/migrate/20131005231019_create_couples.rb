class CreateCouples < ActiveRecord::Migration
  def change
    create_table :couples do |t|
      t.string :ability
      t.timestamps
    end
  end
end
