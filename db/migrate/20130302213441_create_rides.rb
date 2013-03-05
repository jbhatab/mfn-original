class CreateRides < ActiveRecord::Migration
  def self.up
    create_table :rides do |t|
      t.references :festival
      t.references :user
      t.date :leave_date
      t.date :return_date
      t.boolean :giving_ride
      t.decimal :cost
      t.string :address
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end
    add_index :rides, :festival_id
    add_index :rides, :user_id
    
  end

  def self.down
    drop_table :rides
  end
end
