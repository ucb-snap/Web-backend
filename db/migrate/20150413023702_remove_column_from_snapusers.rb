class RemoveColumnFromSnapusers < ActiveRecord::Migration
  def change
    remove_column :snapusers, :account_type
  end
end
