class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.text :description
      t.datetime :date
      t.references :host, foreign_key: true
      t.references :visitor, foreign_key: true
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
