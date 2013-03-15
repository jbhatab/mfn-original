class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :website
      t.string :facebook
      t.string :img_url
      t.string :twitter

      t.timestamps
    end
  end
end
