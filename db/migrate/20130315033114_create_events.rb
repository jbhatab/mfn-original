class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :festival_year

      t.string :event_type
      t.date :start_at
      t.date :end_at
      
      t.timestamps
    end
    add_index :events, :festival_year_id
  end

end
