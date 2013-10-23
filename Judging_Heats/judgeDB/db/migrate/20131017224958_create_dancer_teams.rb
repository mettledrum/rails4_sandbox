class CreateDancerTeams < ActiveRecord::Migration
  def change
    create_table :dancer_teams do |t|
      t.integer :team_id
      t.integer :dancer_id

      t.timestamps
    end
  end
end
