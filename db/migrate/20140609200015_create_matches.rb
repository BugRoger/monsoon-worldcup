class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :arena_id
      t.integer :location_id
      t.time :start
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :stage_id
      t.integer :group_id

      t.timestamps
    end
  end
end
