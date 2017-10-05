class AddCostToReservationHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :reservation_histories, :total_charges, :decimal, :scale => 2, :precision => 30
    
  end
end
