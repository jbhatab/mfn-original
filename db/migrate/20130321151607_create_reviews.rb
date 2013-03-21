class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :festival

      t.integer :rating
      t.integer :security

      t.string :title
      t.text :content

      t.text :atmosphere
      t.text :music
      t.text :staging
      t.text :vendors
      t.text :amenities
      t.text :vip
      t.text :parking
      t.integer :year

      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :festival_id
  end
end
