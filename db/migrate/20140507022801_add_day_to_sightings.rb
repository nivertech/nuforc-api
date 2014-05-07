class AddDayToSightings < ActiveRecord::Migration
  def change
    add_column :sightings, :day, :string
  end
end
