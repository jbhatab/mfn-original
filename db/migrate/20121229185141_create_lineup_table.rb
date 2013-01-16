class CreateLineupTable < ActiveRecord::Migration
  def up
    create_table :lineups do |t|
      t.integer :user_id
      t.integer :festival_id
      
      t.timestamps
    end
    add_index :lineups, :user_id
    add_index :lineups, :festival_id
  end

  def down
    drop_table :lineups
  end
end
