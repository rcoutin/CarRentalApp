class AddColumnToCarApprovals < ActiveRecord::Migration[5.1]
  def change
  	add_column :car_approvals, :customer_id, :integer
  end
end
