class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :course_id
      t.integer :template_id
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :deadline
    end
    add_column :projects, :assignment_id, :integer
  end
end
