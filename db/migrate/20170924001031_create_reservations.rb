class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :customer, index: { unique: true }
      t.belongs_to :car, index: { unique: true }
      t.datetime :from_time
      t.datetime :to_time

      t.timestamps
    end
  end
end
