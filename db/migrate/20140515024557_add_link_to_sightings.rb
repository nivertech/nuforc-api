class AddLinkToSightings < ActiveRecord::Migration
  def change
    add_column :sightings, :link, :string
  end
end
