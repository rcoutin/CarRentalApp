class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :customer_id
      t.integer :car_id

      t.timestamps
    end
  end
end
