class RemoveArenaIdFromMatch < ActiveRecord::Migration
  def change
    remove_column :matches, :arena_id
  end
end
