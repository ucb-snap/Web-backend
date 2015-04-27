class ChangeSnapcommentsToComments < ActiveRecord::Migration
  def change
    rename_table :snapcomments, :comments
  end
end
