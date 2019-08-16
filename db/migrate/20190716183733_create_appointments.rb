class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.text :description
      t.date :date
      t.boolean :professional
      t.references :host, foreign_key: { to_table: :residents }
      t.references :visitor, polymorphic: true, index: true
      t.references :created_by, foreign_key: { to_table: :users }
      t.references :updated_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
