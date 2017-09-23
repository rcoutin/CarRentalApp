class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :manufacturer
      t.string :model_name
      t.string :license_number
      t.string :status

      t.timestamps
    end
  end
end
