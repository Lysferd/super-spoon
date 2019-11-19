class AddPlateToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :plate, :string
  end
end
