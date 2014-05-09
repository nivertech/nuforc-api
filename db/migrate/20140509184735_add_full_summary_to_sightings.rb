class AddFullSummaryToSightings < ActiveRecord::Migration
  def change
    add_column :sightings, :full_summary, :text
  end
end
