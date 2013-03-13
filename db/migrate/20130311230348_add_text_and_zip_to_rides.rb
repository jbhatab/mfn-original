class AddTextAndZipToRides < ActiveRecord::Migration
  def change
    add_column :rides, :message, :text
    add_column :rides, :zip, :integer
  end
end
