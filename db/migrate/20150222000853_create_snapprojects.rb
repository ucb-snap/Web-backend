class CreateSnapprojects < ActiveRecord::Migration
  def change
    create_table :snapprojects
    add_column :snapprojects, :snapuser_id, :integer
    add_column :snapprojects, :name, :string
    add_column :snapprojects, :description, :string
    add_column :snapprojects, :owners, :string
    add_column :snapprojects, :class, :string
    add_column :snapprojects, :privacy, :string
  end
end