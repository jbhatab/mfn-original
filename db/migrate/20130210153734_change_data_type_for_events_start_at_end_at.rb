class ChangeDataTypeForEventsStartAtEndAt < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.change :start_at, :date
      t.change :end_at, :date
    end
  end
 
  def down
    change_table :events do |t|
      t.change :start_at, :datetime
      t.change :end_at, :datetime
    end
  end
end
