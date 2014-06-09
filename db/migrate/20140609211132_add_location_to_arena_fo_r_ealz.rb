class AddLocationToArenaFoREalz < ActiveRecord::Migration
  def change
    add_column :arenas, :location_id, :integer
  end
end
