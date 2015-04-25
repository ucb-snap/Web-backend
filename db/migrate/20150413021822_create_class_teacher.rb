class CreateClassTeacher < ActiveRecord::Migration
  def change
    create_table :class_teachers do |t|
      t.integer :snapuser_id
      t.integer :snapclass_id
    end
  end
end
