class RemovePostedOnFromSightings < ActiveRecord::Migration
  def change
    remove_column :sightings, :posted_on, :date
  end
end
