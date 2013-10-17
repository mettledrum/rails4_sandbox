class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :given_number

      t.timestamps
    end
  end
end
