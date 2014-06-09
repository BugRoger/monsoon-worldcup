class AddStartsAtToMatch < ActiveRecord::Migration
  def change
    add_column    :matches, :starts_at, :datetime
    remove_column :matches, :start
  end
end
