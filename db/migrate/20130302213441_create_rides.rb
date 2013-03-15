class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.references :event
      t.references :user
      
      t.date :leave_date
      t.date :return_date
      t.boolean :giving_ride
      t.decimal :cost
      t.text :message

      t.timestamps
    end
    add_index :rides, :event_id
    add_index :rides, :user_id
    
  end
end
