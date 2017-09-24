class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :customer_id
      t.string :car_id
      t.datetime :from_time
      t.datetime :to_time

      t.timestamps
    end
  end
end
