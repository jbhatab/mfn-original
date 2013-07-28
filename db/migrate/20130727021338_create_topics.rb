class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :last_poster_id
      t.datetime :last_post_at
      t.references :user
      t.references :forum

      t.timestamps
    end
    add_index :topics, :user_id
    add_index :topics, :forum_id
  end
end
