class RenameCarColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :cars, :model_name, :model
  end
end
