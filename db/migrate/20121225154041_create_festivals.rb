class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :city
      t.string :state
      t.float :lat
      t.float :long
      t.date :start_date
      t.date :end_date
      t.string :website
      t.string :facebook
      t.string :region
      t.string :festivaltype
      t.string :img_url
      t.string :lg_img_url
      t.integer :zip 
      t.string :address
      t.string :twitter

      t.timestamps
    end
  end
end
