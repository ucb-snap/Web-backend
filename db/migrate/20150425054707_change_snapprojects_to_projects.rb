class ChangeSnapprojectsToProjects < ActiveRecord::Migration
  def change
    rename_table :snapprojects, :projects
    rename_column :snapcomments, :snapproject_id, :project_id
    rename_column :user_projects, :snapproject_id, :project_id
  end
end
