class CreateTrainers < ActiveRecord::Migration[7.0]
  def change
    create_table :trainers do |t|
      t.string :name
      t.integer :age
      t.string :phone_number
      t.string :experience
      t.string :training_type
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
