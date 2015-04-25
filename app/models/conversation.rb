class Conversation < ActiveRecord::Base
	has_and_belongs_to_many :users, join_table: 'user_conversations'
	has_many :messages
	def all_users
		lst_users = []
	    self.users.each do |user|
	    	if lst_users.include? user.username
	    		next
	    	else
	      		lst_users += [user.username]
	      	end
	    end
	    return "#{lst_users.join(" ")}"
	end

	def check (lst)
		lst.sort!
		temp2 = self.users.sort
		return lst == temp2
	end
end
