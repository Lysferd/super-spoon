class CreateHosts < ActiveRecord::Migration[5.2]
  def change
    create_table :hosts do |t|
      t.string :name
      t.references :facility, foreign_key: true

      t.timestamps
    end
  end
end
