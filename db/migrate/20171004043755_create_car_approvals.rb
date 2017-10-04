class CreateCarApprovals < ActiveRecord::Migration[5.1]
  def change
    create_table :car_approvals do |t|
      t.string :manufacturer
      t.string :model
      t.string :license_number
      t.string :status
      t.decimal :rate
      t.string :style
      t.string :location

      t.timestamps
    end
  end
end
