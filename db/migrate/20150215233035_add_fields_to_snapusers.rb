class AddFieldsToSnapusers < ActiveRecord::Migration
  def change
    create_table :snapusers
    add_column :snapusers, :username, :string
    add_column :snapusers, :account_type, :string
    add_column :snapusers, :snapclass_id, :integer
  end
end
