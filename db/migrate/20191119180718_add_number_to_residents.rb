class AddNumberToResidents < ActiveRecord::Migration[5.2]
  def change
    add_column :residents, :number, :string
  end
end
