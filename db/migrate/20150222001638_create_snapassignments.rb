class CreateSnapassignments < ActiveRecord::Migration
  def change
    create_table :snapassignments
    add_column :snapassignments, :snapclass_id, :integer
    add_column :snapassignments, :title, :string
    add_column :snapassignments, :description, :string
  end
end
