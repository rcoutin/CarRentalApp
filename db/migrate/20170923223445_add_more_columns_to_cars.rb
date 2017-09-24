class AddMoreColumnsToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :rate, :decimal
    add_column :cars, :style, :string
    add_column :cars, :location, :string
  end
end
