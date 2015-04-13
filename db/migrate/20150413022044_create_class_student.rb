class CreateClassStudent < ActiveRecord::Migration
  def change
    create_table :class_students do |t|
      t.integer :snapuser_id
      t.integer :snapclass_id
    end
  end
end
