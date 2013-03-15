class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.integer :zip
      t.string :region
      t.string :country
      t.string :full_name
      t.float :longitude
      t.float :latitude
      t.boolean :gmaps

      t.references :addressable, :polymorphic => true


      t.timestamps
    end
    add_index :addresses, :addressable_type
    add_index :addresses, :addressable_id
  end
end
