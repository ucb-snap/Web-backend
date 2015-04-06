class CreateSnapprojects < ActiveRecord::Migration
  def change
    create_table :snapprojects
    add_column :snapprojects, :name, :string
    add_column :snapprojects, :description, :string
    add_column :snapprojects, :privacy, :string
  end
end
