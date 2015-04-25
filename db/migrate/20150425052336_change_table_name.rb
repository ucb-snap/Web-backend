class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :snapusers, :users
  end
end
