class CreateVisitors < ActiveRecord::Migration[5.2]
  def change
    create_table :visitors do |t|
      t.string :cpf
      t.string :name
      t.string :company

      t.timestamps
    end
  end
end
