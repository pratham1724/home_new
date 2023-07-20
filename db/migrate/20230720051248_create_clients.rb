class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.integer :age
      t.string :phone_number
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
