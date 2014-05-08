class AddMonthIdToSightings < ActiveRecord::Migration
  def change
    add_column :sightings, :month_id, :integer
  end
end
