class CreateSnapclasses < ActiveRecord::Migration
  def change
    create_table :snapclasses
    add_column :snapclasses, :teacher_id, :integer
    add_column :snapclasses, :title, :string
    add_column :snapclasses, :description, :string
  end
end
