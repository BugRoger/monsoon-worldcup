class AddLocationAgain < ActiveRecord::Migration
  def change
    add_column :locations, :arena_id, :integer
  end
end
