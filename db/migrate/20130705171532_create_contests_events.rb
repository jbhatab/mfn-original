class CreateContestsEvents < ActiveRecord::Migration
  def change
    create_table :contests_events do |t|
      t.references :event
      t.references :contest

      t.timestamps
    end
    add_index :contests_events, :event_id
    add_index :contests_events, :contest_id
  end
end
