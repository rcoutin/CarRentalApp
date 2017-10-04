class AddCostToReservation < ActiveRecord::Migration[5.1]
  def change

    add_column :reservations, :total_charges, :decimal, :precision => 2
  end
end
