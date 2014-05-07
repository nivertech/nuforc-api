class AddTimeToSightings < ActiveRecord::Migration
  def change
    add_column :sightings, :time, :string
  end
end
