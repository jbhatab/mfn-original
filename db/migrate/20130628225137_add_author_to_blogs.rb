class AddAuthorToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :author, :string
  end
end
