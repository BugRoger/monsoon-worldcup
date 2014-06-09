class RemoveGroupFromMatch < ActiveRecord::Migration
  def change
    remove_column :matches, :group_id
  end
end
