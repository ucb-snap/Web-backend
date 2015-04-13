class CreateUserConversationsJoinTable < ActiveRecord::Migration
	def change
  		create_table :user_conversations, id: false do |t|
  			t.integer :snapuser_id
  			t.integer :conversation_id
  		end
  	end
end
