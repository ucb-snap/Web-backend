class CreateSnapclasses < ActiveRecord::Migration
  def change
    create_table :snapclasses
    add_column :snapclasses, :teacher_id, :integer
    add_column :snapclasses, :title, :string
    add_column :snapclasses, :description, :string
    add_column :snapclasses, :privacy, :string
  end
end
