class AddLinkToMonths < ActiveRecord::Migration
  def change
    add_column :months, :link, :string
  end
end
