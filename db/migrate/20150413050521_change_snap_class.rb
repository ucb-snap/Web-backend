class ChangeSnapClass < ActiveRecord::Migration
  def change
    remove_column :snapclasses, :is_public
  end
end
