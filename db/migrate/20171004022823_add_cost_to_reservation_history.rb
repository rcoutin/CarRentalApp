class AddCostToReservationHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :reservation_histories, :total_charges, :decimal, :precision => 2
    
  end
end
