class CreateUsersProjectsJoinTable < ActiveRecord::Migration
  def change
  	create_table :user_projects, id: false do |t|
  		t.integer :snapuser_id
  		t.integer :snapproject_id
  	end
  end
end
