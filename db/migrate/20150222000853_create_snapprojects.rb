class CreateSnapprojects < ActiveRecord::Migration
  def change
    create_table :snapprojects
    add_column :snapprojects, :snapuser_id, :integer
    add_column :snapprojects, :tite, :string
    add_column :snapprojects, :description, :string
  end
end
