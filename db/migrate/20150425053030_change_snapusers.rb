class ChangeSnapusers < ActiveRecord::Migration
  def change
    rename_column :class_students, :snapuser_id, :user_id
    rename_column :class_teachers, :snapuser_id, :user_id
    rename_column :messages, :snapuser_id, :user_id
    rename_column :snapcomments, :snapuser_id, :user_id
    rename_column :user_conversations, :snapuser_id, :user_id
    rename_column :user_projects, :snapuser_id, :user_id
  end
end
