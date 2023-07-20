class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :client, null: false, foreign_key: true
      t.references :trainer, null: false, foreign_key: true
      t.boolean :confirmed

      t.timestamps
    end
  end
end
