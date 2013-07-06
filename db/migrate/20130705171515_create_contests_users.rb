class CreateContestsUsers < ActiveRecord::Migration
  def change
    create_table :contests_users do |t|
      t.references :user
      t.references :contest

      t.timestamps
    end
    add_index :contests_users, :user_id
    add_index :contests_users, :contest_id
  end
end
