class RemoveMonthIdFromSightings < ActiveRecord::Migration
  def change
    remove_column :sightings, :month_id, :integer
  end
end
