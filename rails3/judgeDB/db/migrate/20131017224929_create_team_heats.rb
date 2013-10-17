class CreateTeamHeats < ActiveRecord::Migration
  def change
    create_table :team_heats do |t|
      t.integer :team_id
      t.integer :heat_id
      t.integer :judge_id
      t.integer :score

      t.timestamps
    end
  end
end
