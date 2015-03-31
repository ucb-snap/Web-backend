class RemoveDescriptionFromProjects < ActiveRecord::Migration
  def change
  	remove_column :snapprojects, :snapuser_id, :integer
  	remove_column :snapprojects, :owners, :string
  end
end
