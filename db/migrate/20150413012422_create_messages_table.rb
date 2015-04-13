class CreateMessagesTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :snapuser_id
    	t.integer :conversation_id
    	t.datetime :message_time
    	t.text :content
    end
  end
end
