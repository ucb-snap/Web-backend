class Conversation < ActiveRecord::Base
	has_and_belongs_to_many :snapusers, join_table: 'user_conversations'
	has_many :messages
	@@lst_users = []
	def all_users
	    self.snapusers.each do |user|
	    	if @@lst_users.include? user.username
	    		next
	    	else
	      		@@lst_users += [user.username]
	      	end
	    end
	    return "#{@@lst_users.join(" ")}"
	end

	def check (lst)
		lst.sort!
		temp2 = self.snapusers.sort
		return lst == temp2
	end
end
