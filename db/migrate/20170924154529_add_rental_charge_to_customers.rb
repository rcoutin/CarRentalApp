class AddRentalChargeToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :rental_charge, :real, :default => 0.0
  end
end
