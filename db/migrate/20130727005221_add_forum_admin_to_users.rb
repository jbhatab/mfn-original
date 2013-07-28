class AddForumAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forum_admin, :boolean
  end
end
