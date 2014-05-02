class AddYearAndMonthToMonths < ActiveRecord::Migration
  def change
    add_column :months, :year, :string
    add_column :months, :month, :string
  end
end
