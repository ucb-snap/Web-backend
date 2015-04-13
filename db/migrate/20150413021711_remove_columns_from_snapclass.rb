class RemoveColumnsFromSnapclass < ActiveRecord::Migration
  def change
    remove_column :snapclasses, :teacher_id
  end
end
