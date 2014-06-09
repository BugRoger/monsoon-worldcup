class RemoveArenaIdFromLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :arena_id
  end
end
