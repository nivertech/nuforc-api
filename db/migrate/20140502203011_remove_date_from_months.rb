class RemoveDateFromMonths < ActiveRecord::Migration
  def change
    remove_column :months, :date, :date
  end
end
