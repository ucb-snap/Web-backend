class AddColumnsToClasses < ActiveRecord::Migration
  def change
  	add_column :snapclasses, :is_public, :boolean
  end
end
