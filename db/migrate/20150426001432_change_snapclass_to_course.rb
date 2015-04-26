class ChangeSnapclassToCourse < ActiveRecord::Migration
  def change
    rename_table :snapclasses, :courses
    rename_table :class_students, :course_students
    rename_table :class_teachers, :course_teachers
    remove_column :users, :snapclass_id
    rename_column :snapassignments, :snapclass_id, :course_id
    rename_column :course_students, :snapclass_id, :course_id
    rename_column :course_teachers, :snapclass_id, :course_id
  end
end
