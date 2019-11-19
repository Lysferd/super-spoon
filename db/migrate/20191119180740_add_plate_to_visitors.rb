class AddPlateToVisitors < ActiveRecord::Migration[5.2]
  def change
    add_column :visitors, :plate, :string
  end
end
