class DropMonths < ActiveRecord::Migration
  def up
    drop_table :months
  end
end
