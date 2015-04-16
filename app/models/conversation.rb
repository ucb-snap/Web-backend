class Conversation < ActiveRecord::Base
	has_and_belongs_to_many :snapusers, join_table: 'user_conversations'
	has_many :messages
	def all_users
	    string = ""
	    self.snapusers.each do |user|
	      string += "#{user.username} "
	    end
	    string
	end

	def check (lst)
		lst.sort!
		temp2 = self.snapusers.sort
		return lst == temp2
	end

end
