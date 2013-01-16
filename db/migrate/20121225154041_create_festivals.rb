class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :city
      t.string :state
      t.float :lat
      t.float :long
      t.date :date
      t.string :genre
      t.string :website

      t.timestamps
    end
  end
end
