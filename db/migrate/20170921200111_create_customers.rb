class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    drop_table :customers
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.date :date_of_birth
      t.string :license_number

      t.timestamps
    end
  end
end
