class CreateSightings < ActiveRecord::Migration
  def change
    create_table :sightings do |t|
      t.datetime :seen_when
      t.string :city
      t.string :state
      t.string :shape
      t.string :duration
      t.text :summary
      t.date :posted_on

      t.timestamps
    end
  end
end
