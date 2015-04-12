class CreateSnapCommentTable < ActiveRecord::Migration
  def change
    create_table :snapcomments do |t|
    	t.integer :snapuser_id
    	t.integer :snapproject_id
    	t.datetime :comment_time
    	t.string :content
    end
  end
end
	