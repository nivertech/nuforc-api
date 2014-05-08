class AddYearAndMonthToSightings < ActiveRecord::Migration
  def change
    add_column :sightings, :year, :string
    add_column :sightings, :month, :string
  end
end
