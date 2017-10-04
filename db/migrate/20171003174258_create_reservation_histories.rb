class CreateReservationHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_histories do |t|
      t.integer :reservation_id
      t.integer :customer_id
      t.integer :car_id
      t.datetime :from_time
      t.datetime :to_time

      t.timestamps
    end
  end
end
