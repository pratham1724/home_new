class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.integer :client_id
      t.integer :trainer_id

      t.timestamps
    end
  end
end
