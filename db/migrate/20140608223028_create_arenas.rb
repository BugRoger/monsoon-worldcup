class CreateArenas < ActiveRecord::Migration
  def change
    create_table :arenas do |t|
      t.string :name

      t.timestamps
    end
  end
end
