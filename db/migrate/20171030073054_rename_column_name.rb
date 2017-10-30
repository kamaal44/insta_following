class RenameColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :partners, :user_name, :name
  end
end
