class CreateHeats < ActiveRecord::Migration
  def change
    create_table :heats do |t|
      t.string :level

      t.timestamps
    end
  end
end
