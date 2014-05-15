class RemoveFullSummaryFromSightings < ActiveRecord::Migration
  def change
    remove_column :sightings, :full_summary, :text
  end
end
