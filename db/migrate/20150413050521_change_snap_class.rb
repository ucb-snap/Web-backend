class ChangeSnapClass < ActiveRecord::Migration
  def change
    remove_column :snapclasses, :is_public
    add_column :snapclasses, :privacy, :string
  end
end
