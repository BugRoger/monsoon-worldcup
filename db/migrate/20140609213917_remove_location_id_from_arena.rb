class RemoveLocationIdFromArena < ActiveRecord::Migration
  def change
    remove_column :arenas, :location_id
  end
end
