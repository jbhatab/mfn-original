class CreateFestivalYears < ActiveRecord::Migration
  def change
    create_table :festival_years do |t|
      t.references :festival
      t.integer :festival_year

      t.timestamps
    end

    add_index :festival_years, :festival_id
  end
end
