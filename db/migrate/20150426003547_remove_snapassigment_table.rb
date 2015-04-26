class RemoveSnapassigmentTable < ActiveRecord::Migration
  def change
    drop_table :snapassignments
  end
end
