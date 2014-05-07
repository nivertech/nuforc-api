class RemoveSeenWhenFromSightings < ActiveRecord::Migration
  def change
    remove_column :sightings, :seen_when, :datetime
  end
end
